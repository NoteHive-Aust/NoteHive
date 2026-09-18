import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notehive/Structures/userStructure.dart';

class Room {
  final String name;
  final String schoolName;
  final String roomCode;
  final dynamic adminID;
  List<DocumentReference<Map<String, dynamic>>> moderators;
  List<DocumentReference<Map<String, dynamic>>> members;
  List<DocumentReference<Map<String, dynamic>>> resources;
  final bool isPublic;
  List<dynamic> categories;
  List<DocumentReference<Map<String, dynamic>>> Announcements;
  List<DocumentReference<Map<String, dynamic>>> pendingApprovals = [];
  final bool onlyModeratorUpload;
  Room({
    required this.name,
    required this.schoolName,
    required this.adminID,
    required this.moderators,
    required this.roomCode,
    required this.members,
    required this.resources,
    required this.isPublic,
    required this.categories,
    required this.Announcements,
    required this.pendingApprovals,
    required this.onlyModeratorUpload,
  });
  factory Room.fromMap(Map<String, dynamic> data) {
    return Room(
      name: data['Name'] ?? '',
      schoolName: data['SchoolName'] ?? '',
      roomCode: data['RoomCode'] ?? '',
      adminID: data['Admin'] ?? null,
      moderators: List<DocumentReference<Map<String, dynamic>>>.from(
        data['Moderators'] ?? [],
      ),
      members: List<DocumentReference<Map<String, dynamic>>>.from(
        data['Members'] ?? [],
      ),
      resources: List<DocumentReference<Map<String, dynamic>>>.from(
        data['Resources'] ?? [],
      ),
      isPublic: data['IsPublic'] ?? null,
      categories: data['Categories'] ?? [],
      Announcements: List<DocumentReference<Map<String, dynamic>>>.from(
        data['Announcements'] ?? [],
      ),
      pendingApprovals: List<DocumentReference<Map<String, dynamic>>>.from(
        data['PendingApprovals'] ?? [],
      ),
      onlyModeratorUpload: data["OnlyModeratorUpload"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'SchoolName': schoolName,
      'RoomCode': roomCode,
      'Admin': adminID,
      'Moderators': moderators,
      'Members': members,
      'Resources': resources,
      'IsPublic': isPublic,
      'Categories': categories,
      'Announcements': Announcements,
      'PendingApprovals': pendingApprovals,
      'OnlyModeratorUpload':onlyModeratorUpload,
    };
  }
}
