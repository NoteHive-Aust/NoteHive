import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notehive/Screens/RoomScreen_adminOrMod.dart';
import 'package:notehive/Screens/joinRoom.dart';
import 'package:notehive/Screens/roomScreen.dart';
import 'package:notehive/Structures/roomStructure.dart';

Container listTileforBrowseRoom({
  required BuildContext context,
  required QueryDocumentSnapshot<Object?> room,
  required String uid,
}) {
  return Container(
    // margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xff352E60).withOpacity(0.1)),
      borderRadius: BorderRadius.circular(16),
    ),
    child: ListTile(
      title: Text(
        room['Name'] ?? '',
        style: TextStyle(
          color: Color(0xff1A1730),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(Icons.people_alt_outlined, size: 16),
          SizedBox(width: 5),
          Text(
            ' ${room['Members'].length} ',
            style: TextStyle(
              color: Color(0xff352E60),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Members',
            style: TextStyle(color: Color(0xff352E60).withOpacity(0.6)),
          ),
          SizedBox(width: 5),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Color(0xFF352E60).withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(200),
              color: Colors.white,
            ),

            child: Row(
              children: [
                room['IsPublic'] == false
                    ? Icon(Icons.lock_outline_rounded, size: 12)
                    : Icon(Icons.lock_open_rounded, size: 12),
                SizedBox(width: 2),
                Text(
                  " ${room['IsPublic'] == false ? "Private" : "Public"}",
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),

      trailing: OutlinedButton(
        onPressed: () {
          if (room['IsPublic'] == false) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Joinroom()),
            );
          } else {
            FirebaseFirestore.instance.collection('Users').doc(uid).update({
              'MemberAt': FieldValue.arrayUnion([
                FirebaseFirestore.instance.doc('Rooms/${room.id}'),
              ]),
            });
            FirebaseFirestore.instance
                .collection('Rooms')
                .doc(room.id)
                .update({
                  'Members': FieldValue.arrayUnion([
                    FirebaseFirestore.instance.doc('Users/$uid'),
                  ]),
                })
                .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomScreen(
                        room: Room.fromMap(room.data() as Map<String, dynamic>),

                        roomId: room.id,
                      ),
                    ),
                  );
                })
                .catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to join the room: $error')),
                  );
                });
          }
        },
        style: OutlinedButton.styleFrom(
          overlayColor: Color(0xff8474F0),
          side: BorderSide(color: Color(0xff352E60).withOpacity(0.1)),
          visualDensity: VisualDensity.compact,
          // fixedSize: Size(75,25)
        ),
        child: Text(
          "Join",
          style: TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      style: ListTileStyle.drawer,
    ),
  );
}
