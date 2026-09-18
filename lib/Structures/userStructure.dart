import 'package:notehive/Structures/roomStructure.dart';

class User{
  final String name;
  List<Room> memberAt;
  User({required this.name,required this.memberAt});
}