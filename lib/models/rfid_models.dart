import 'package:firebase_database/firebase_database.dart';

/// items/{uid} : 어드민이 등록하는 물품 정보. user 페이지가 이걸 파싱해서 사용.
class RfidItem {
  final String uid;
  final String name;
  final int price;
  final String imageUrl;
  final int? registeredAt;

  const RfidItem({
    required this.uid,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.registeredAt,
  });

  factory RfidItem.fromSnapshot(String uid, DataSnapshot snap) {
    final map = Map<String, dynamic>.from(snap.value as Map);
    return RfidItem(
      uid: uid,
      name: (map['name'] ?? '').toString(),
      price: _asInt(map['price']),
      imageUrl: (map['imageUrl'] ?? '').toString(),
      registeredAt: map['registeredAt'] is int ? map['registeredAt'] as int : null,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
        'registeredAt': ServerValue.timestamp,
      };
}

/// logs/{autoId} : ESP8266 이 카드 태깅시 POST. { uid, timestamp }
class ScanLog {
  final String key;
  final String uid;
  final dynamic timestamp;

  const ScanLog({required this.key, required this.uid, required this.timestamp});

  factory ScanLog.fromSnapshot(DataSnapshot snap) {
    final map = Map<String, dynamic>.from(snap.value as Map);
    return ScanLog(
      key: snap.key ?? '',
      uid: (map['uid'] ?? '').toString(),
      timestamp: map['timestamp'],
    );
  }

  /// ESP8266 timestamp 포맷 불명 → epoch(ms/s) 또는 문자열 모두 처리.
  DateTime? get dateTime {
    final ts = timestamp;
    if (ts is int) {
      // 13자리 = ms, 10자리 = s
      return ts > 1000000000000
          ? DateTime.fromMillisecondsSinceEpoch(ts)
          : DateTime.fromMillisecondsSinceEpoch(ts * 1000);
    }
    if (ts is String) {
      final asNum = int.tryParse(ts);
      if (asNum != null) {
        return asNum > 1000000000000
            ? DateTime.fromMillisecondsSinceEpoch(asNum)
            : DateTime.fromMillisecondsSinceEpoch(asNum * 1000);
      }
      return DateTime.tryParse(ts);
    }
    return null;
  }
}

int _asInt(dynamic v) {
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) return int.tryParse(v) ?? 0;
  return 0;
}
