import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot> fetchAvailableRooms(String uid) {
  return FirebaseFirestore.instance.collection('Rooms').where("IsPublic", isEqualTo: true)
  .limit(10).get();
}
