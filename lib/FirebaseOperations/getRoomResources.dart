import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot> getRoomResources({required String? roomId}) async {
  final roomSnapshot = await FirebaseFirestore.instance
      .collection('Rooms')
      .doc(roomId)
      .get();

  final List<DocumentReference<Map<String, dynamic>>> resourcesRef =
      List<DocumentReference<Map<String, dynamic>>>.from(
        roomSnapshot.data()?['Resources'] ?? [],
      );
  return await FirebaseFirestore.instance
      .collection('Resources')
      .where(
        FieldPath.documentId,
        whereIn: resourcesRef.map((ref) => ref.id).toList(),
      )
      .get();
}

Future<QuerySnapshot> getRoomResourcesFiltered({required String? roomId}) {
  return FirebaseFirestore.instance
      .collection('Rooms')
      .doc(roomId)
      .collection('Resources')
      .get();
}
