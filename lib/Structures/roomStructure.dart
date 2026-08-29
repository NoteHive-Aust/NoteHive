import 'package:notehive/Structures/userStructure.dart';

class Room{
  final String name;
  final String schoolName;
  final String roomCode;
  final User admin;
  List<User> moderators;
  Room({required this.name,required this.schoolName,required this.admin,required this.moderators,required this.roomCode});
}