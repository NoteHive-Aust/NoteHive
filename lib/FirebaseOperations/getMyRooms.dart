import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot<Map<String, dynamic>>> getMyRooms(String uid) async {
  final userSnapshot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .get();

  final List<DocumentReference<Map<String, dynamic>>> roomRefs =
      List<DocumentReference<Map<String, dynamic>>>.from(
    userSnapshot.data()?['MemberAt'] ?? [],
  );

  if (roomRefs.isEmpty) {
    // Can't return an empty QuerySnapshot directly.
    // Handle this case separately.
    throw Exception('User is not a member of any room');
  }

  return await FirebaseFirestore.instance
      .collection('Rooms')
      .where(
        FieldPath.documentId,
        whereIn: roomRefs.map((ref) => ref.id).toList(),
      )
      .get();
}
