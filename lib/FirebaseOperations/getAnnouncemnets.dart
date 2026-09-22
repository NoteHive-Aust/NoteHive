import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notehive/Structures/roomStructure.dart';

Future<QuerySnapshot> getAnnouncement({required String roomId}) {
  return FirebaseFirestore.instance
      .collection('Notifications')
      .where('Room', isEqualTo: roomId)
      .get();
}
