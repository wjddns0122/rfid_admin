import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/rfid_models.dart';
import '../services/rfid_database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/item_register_dialog.dart';

/// 스캔 이력 1건. name 이 null 이면 미등록 상태.
class _ScanRecord {
  final String key;
  final String uid;
  final DateTime? time;
  String? name;
  bool registered;

  _ScanRecord({
    required this.key,
    required this.uid,
    required this.time,
    this.name,
    this.registered = false,
  });
}

class RfidScanMonitorScreen extends StatefulWidget {
  const RfidScanMonitorScreen({super.key});

  @override
  State<RfidScanMonitorScreen> createState() => _RfidScanMonitorScreenState();
}

class _RfidScanMonitorScreenState extends State<RfidScanMonitorScreen> {
  final _service = RfidDatabaseService();
  final List<_ScanRecord> _records = []; // 최신순
  final Set<String> _seenKeys = {};

  StreamSubscription<DatabaseEvent>? _sub;
  bool _loading = true;
  String? _error;

  // 다이얼로그가 동시에 여러 개 뜨지 않도록 순차 처리.
  final List<String> _dialogQueue = [];
  bool _dialogShowing = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _init() async {
    try {
      // 1) 기존 로그 로드 (다이얼로그 없이 이력만 표시).
      final existing = await _service.loadRecentLogs();
      for (final log in existing) {
        _seenKeys.add(log.key);
      }
      // 최신순 정렬용: 로드된 순서가 오래된→최신 이므로 역순으로 추가.
      for (final log in existing.reversed) {
        final item = await _service.getItem(log.uid);
        _records.add(_ScanRecord(
          key: log.key,
          uid: log.uid,
          time: log.dateTime,
          name: item?.name,
          registered: item != null,
        ));
      }
      if (!mounted) return;
      setState(() => _loading = false);

      // 2) 신규 로그 구독.
      _sub = _service.onLogAdded.listen(_onLogAdded, onError: (e) {
        if (mounted) setState(() => _error = '$e');
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = '$e';
        });
      }
    }
  }

  void _onLogAdded(DatabaseEvent event) {
    final snap = event.snapshot;
    final key = snap.key;
    if (key == null || snap.value is! Map) return;
    if (_seenKeys.contains(key)) return; // 시작 시점 이전 로그는 무시.
    _seenKeys.add(key);
    _handleNewScan(ScanLog.fromSnapshot(snap));
  }

  Future<void> _handleNewScan(ScanLog log) async {
    final item = await _service.getItem(log.uid);
    if (!mounted) return;

    final record = _ScanRecord(
      key: log.key,
      uid: log.uid,
      time: log.dateTime,
      name: item?.name,
      registered: item != null,
    );
    setState(() => _records.insert(0, record));

    if (item != null) {
      // 이미 등록됨 → 스낵바.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이미 등록된 상품: ${item.name}'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      // 미등록 → 등록 다이얼로그 큐에 넣기.
      _enqueueRegister(log.uid);
    }
  }

  /// 미등록 UID 등록 요청 (신규 스캔 자동 / 타일 탭 둘 다 사용). 중복 큐 방지.
  void _enqueueRegister(String uid) {
    if (_dialogQueue.contains(uid)) return;
    _dialogQueue.add(uid);
    _processDialogQueue();
  }

  Future<void> _processDialogQueue() async {
    if (_dialogShowing || _dialogQueue.isEmpty || !mounted) return;
    _dialogShowing = true;
    final uid = _dialogQueue.removeAt(0);

    final input = await showItemRegisterDialog(context, uid: uid);
    if (input != null) {
      try {
        await _service.registerItem(
          uid: uid,
          name: input.name,
          price: input.price,
          imageUrl: input.imageUrl,
        );
        if (mounted) {
          setState(() {
            for (final r in _records) {
              if (r.uid == uid && !r.registered) {
                r.name = input.name;
                r.registered = true;
              }
            }
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('등록 완료: ${input.name}'),
              backgroundColor: const Color(0xFF16A34A),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('등록 실패: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }

    _dialogShowing = false;
    if (mounted) _processDialogQueue(); // 큐에 남은 다음 항목 처리.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Color(0xFF464554), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: const Text(
          'RFID 스캔 모니터',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            '연결 오류:\n$_error',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }
    return Column(
      children: [
        _StatusBanner(count: _records.length),
        Expanded(
          child: _records.isEmpty
              ? const Center(
                  child: Text(
                    '아직 스캔 이력이 없습니다.\n카드를 태깅하면 여기에 표시됩니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF94A3B8)),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _records.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final r = _records[i];
                    return _ScanTile(
                      record: r,
                      onTap: r.registered ? null : () => _enqueueRegister(r.uid),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _StatusBanner extends StatelessWidget {
  final int count;
  const _StatusBanner({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF16A34A),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '실시간 수신 중',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),
          const Spacer(),
          Text(
            '최근 $count건',
            style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }
}

class _ScanTile extends StatelessWidget {
  final _ScanRecord record;
  final VoidCallback? onTap;
  const _ScanTile({required this.record, this.onTap});

  String _formatTime(DateTime? t) {
    if (t == null) return '-';
    final l = t.toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${l.year}.${two(l.month)}.${two(l.day)} ${two(l.hour)}:${two(l.minute)}:${two(l.second)}';
  }

  @override
  Widget build(BuildContext context) {
    final registered = record.registered;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: registered
                    ? AppColors.primary.withOpacity(0.1)
                    : const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                registered ? Icons.check_circle_outline : Icons.help_outline,
                color: registered ? AppColors.primary : const Color(0xFFEF4444),
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    registered ? (record.name ?? '-') : '미등록 물품',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: registered
                          ? const Color(0xFF0F172A)
                          : const Color(0xFFEF4444),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'UID ${record.uid}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (!registered) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.touch_app_outlined,
                            size: 13, color: AppColors.primary),
                        SizedBox(width: 3),
                        Text(
                          '탭하여 등록',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Text(
              _formatTime(record.time),
              style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
            ),
          ],
        ),
      ),
    );
  }
}
