import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<DocumentSnapshot<Map<String, dynamic>>>> getNotifications() async {
  QuerySnapshot<Map<String, dynamic>> snapshot;
  try {
    snapshot = await FirebaseFirestore.instance
        .collection('Notifications')
        .orderBy('UploadTime', descending: true)
        .get();
  } catch (e) {
    snapshot = await FirebaseFirestore.instance
        .collection('Notifications')
        .get();
  }

  var docs = snapshot.docs.toList();
  docs.sort((a, b) {
    var aTime = a.data()['UploadTime'];
    var bTime = b.data()['UploadTime'];
    if (aTime is Timestamp && bTime is Timestamp) {
      return bTime.compareTo(aTime);
    }
    if (aTime is Timestamp) return -1;
    if (bTime is Timestamp) return 1;
    return 0;
  });

  if (docs.length > 20) {
    for (int i = 20; i < docs.length; i++) {
      docs[i].reference.delete();
    }
    docs = docs.sublist(0, 20);
  }

  return docs;
}
