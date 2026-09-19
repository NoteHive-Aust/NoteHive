import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notehive/Structures/roomStructure.dart';

class User {
  final String name;
  final String schoolName;
  final String profileUrl;
  final String email;
  final int totalUploads;
  final int repPoints;
  List<DocumentReference<Map<String, dynamic>>> myUploads;
  List<DocumentReference<Map<String, dynamic>>> notifications;
  List<DocumentReference<Map<String, dynamic>>> memberAt;
  User({
    required this.name,
    required this.memberAt,
    required this.schoolName,
    required this.profileUrl,
    required this.email,
    required this.totalUploads,
    required this.repPoints,
    required this.myUploads,
    required this.notifications,
  });
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      name: data['Name'],
      memberAt: data['MemberAt'],
      schoolName: data['SchoolName'],
      profileUrl: data['ProfileImage'],
      email: data['Email'],
      totalUploads: data['TotalUploads'],
      repPoints: data['RepPoints'],
      myUploads: data['MyUploads'],
      notifications: data['Notifications'],
    );
  }
}
