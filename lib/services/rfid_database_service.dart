import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/rfid_models.dart';

/// RTDB 접근. logs 스트림 구독 + items 조회/등록.
class RfidDatabaseService {
  static const String databaseUrl =
      'https://rfid-user-db713-default-rtdb.firebaseio.com/';

  // firebase_options 에 databaseURL 이 없어도 동작하도록 URL 명시.
  final FirebaseDatabase _db = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: databaseUrl,
  );

  DatabaseReference get _logsRef => _db.ref('logs');
  DatabaseReference _itemRef(String uid) => _db.ref('items/$uid');

  /// 최근 50개로 제한한 logs 의 child_added 스트림.
  Stream<DatabaseEvent> get onLogAdded => _logsRef.limitToLast(50).onChildAdded;

  /// 시작 시점에 이미 존재하는 로그를 1회 로드 (이력 표시 + 신규 판별용 키 집합).
  Future<List<ScanLog>> loadRecentLogs() async {
    final snap = await _logsRef.limitToLast(50).get();
    final logs = <ScanLog>[];
    for (final child in snap.children) {
      if (child.value is Map) logs.add(ScanLog.fromSnapshot(child));
    }
    return logs;
  }

  Future<RfidItem?> getItem(String uid) async {
    final snap = await _itemRef(uid).get();
    if (!snap.exists || snap.value is! Map) return null;
    return RfidItem.fromSnapshot(uid, snap);
  }

  Future<void> registerItem({
    required String uid,
    required String name,
    required int price,
    required String imageUrl,
  }) {
    return _itemRef(uid).set({
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'registeredAt': ServerValue.timestamp,
    });
  }
}
