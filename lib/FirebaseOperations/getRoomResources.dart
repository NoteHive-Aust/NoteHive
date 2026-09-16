import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

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

Future<QuerySnapshot> getRoomResourcesFiltered({
  required String? roomId,
  required String filter,
}) async {
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
      ).where('Category' ,isEqualTo: filter)
      .get();
}

Future<QuerySnapshot> getComments({required String resourceId}) {
  return FirebaseFirestore.instance
      .collection('Resources')
      .doc(resourceId)
      .collection('Comments')
      .get();
}
