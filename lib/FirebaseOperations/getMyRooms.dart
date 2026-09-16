import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot> getMyRooms() {
  return FirebaseFirestore.instance.collection('Rooms').get();
}