import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notehive/Structures/roomStructure.dart';

class User {
  final String name;
  final String schoolName;
  final String profileUrl;
  final String email;
  final int totalUploads;
  final int repPoints;
  List<dynamic> myUploads;
  List<dynamic> notifications;
  List<dynamic> memberAt;
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
  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'MemberAt': memberAt,
      'SchoolName': schoolName,
      'ProfileImage': profileUrl,
      'Email': email,
      'TotalUploads': totalUploads,
      'RepPoints': repPoints,
      'MyUploads': myUploads,
      'Notifications': notifications,
    };
  }
}
