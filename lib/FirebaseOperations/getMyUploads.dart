import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<DocumentSnapshot<Map<String, dynamic>>>> getMyUploads(String uid) async {
  final userDoc =
      await FirebaseFirestore.instance.collection('Users').doc(uid).get();
  List<dynamic> uploadsRefs = userDoc.data()?['MyUploads'] ?? [];
  if (uploadsRefs.isEmpty) {
    return [];
  }

  List<Future<DocumentSnapshot<Map<String, dynamic>>>> futures = [];
  for (var ref in uploadsRefs) {
    if (ref is DocumentReference) {
      futures.add((ref as DocumentReference<Map<String, dynamic>>).get());
    } else if (ref is String) {
      futures.add(FirebaseFirestore.instance.doc(ref).get());
    }
  }
  var docs = await Future.wait(futures);
  return docs.where((doc) => doc.exists).toList();
}
