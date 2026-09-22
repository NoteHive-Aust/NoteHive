import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notehive/Structures/announcements.dart';

Future<void> CreateAnnouncement({
  required String roomId,
  required Notifications notification,
}) {
  return FirebaseFirestore.instance
      .collection('Notifications')
      .doc()
      .set(notification.toMap());
}
