import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications {
  final String content;
  final dynamic roomId;
  final String roomName;
  final DateTime uploadTime;

  Notifications({
    required this.content,
    required this.roomId,
    required this.roomName,
    required this.uploadTime,
  });

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      uploadTime: (map["UploadTime"] as Timestamp).toDate(),
      content: map['Content'],
      roomName: map['RoomName'],
      roomId: map['Room'],
    );
  }
}
