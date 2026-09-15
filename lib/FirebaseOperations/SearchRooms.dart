import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot> fetchAvailableRooms() {
  return FirebaseFirestore.instance
      .collection('Rooms')
      .get();
}