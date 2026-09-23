import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<DocumentSnapshot<Map<String, dynamic>>>> getNotifications() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  Set<String> joinedRoomIds = {};
  if (uid != null) {
    final userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    if (userDoc.exists && userDoc.data() != null) {
      final memberAt = userDoc.data()!['MemberAt'] as List<dynamic>? ?? [];
      for (var ref in memberAt) {
        if (ref is DocumentReference) {
          joinedRoomIds.add(ref.id);
        }
      }
    }
  }

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

  if (joinedRoomIds.isNotEmpty) {
    docs = docs.where((doc) {
      final room = doc.data()['Room'];
      if (room is String) {
        return joinedRoomIds.contains(room);
      } else if (room is DocumentReference) {
        return joinedRoomIds.contains(room.id);
      }
      return false;
    }).toList();
  }

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
    docs = docs.sublist(0, 20);
  }

  return docs;
}
