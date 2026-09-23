import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile(String uid) async {
  return await FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .get();
}
