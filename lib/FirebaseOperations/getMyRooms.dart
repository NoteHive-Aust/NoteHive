import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot<Map<String, dynamic>>> getMyRooms(String uid) async {
  return await FirebaseFirestore.instance
      .collection('Rooms')
      .where(
        'Members',
        arrayContains: FirebaseFirestore.instance.doc('Users/$uid'),
      )
      .get();
}
