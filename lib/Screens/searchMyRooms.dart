import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notehive/FirebaseOperations/getMyRooms.dart';
import 'package:notehive/Screens/RoomScreen_adminOrMod.dart';
import 'package:notehive/Screens/roomScreen.dart';
import 'package:notehive/Structures/roomStructure.dart';
import 'package:notehive/widgets/listitemcardforhome.dart';
import 'package:notehive/widgets/searchBox.dart';

class SearchMyRooms extends StatefulWidget {
  const SearchMyRooms({super.key});

  @override
  State<SearchMyRooms> createState() => _SearchMyRoomsState();
}

class _SearchMyRoomsState extends State<SearchMyRooms> {
  String uid = "abc";
  Timer? waitforUserToStopTyping;
  final TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> getMyRoomsfilted() async {
    String searchText = _searchController.text.trim();
    if (searchText.isEmpty) {
      return getMyRooms(uid);
    } else {
      return await FirebaseFirestore.instance
          .collection('Rooms')
          .where(
            'Members',
            arrayContains: FirebaseFirestore.instance.doc('Users/$uid'),
          )
          .where('Name', isGreaterThanOrEqualTo: searchText)
          .where('Name', isLessThanOrEqualTo: searchText + '\uf8ff')
          // .where('RoomCode', isGreaterThanOrEqualTo: searchText)
          // .where('RoomCode', isLessThanOrEqualTo: searchText + '\uf8ff')
          .get();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search My Rooms")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SearchBox(
              lebel: 'Search for room',
              controller: _searchController,
              onChanged: () {
                if (waitforUserToStopTyping != null) {
                  waitforUserToStopTyping!.cancel();
                }
                waitforUserToStopTyping = Timer(
                  const Duration(milliseconds: 500),
                  () {
                    setState(() {});
                  },
                );
              },
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: getMyRoomsfilted(),

                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('Error fetching rooms: ${snapshot.error}');
                    return Center(child: Text('Something went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No documents found.'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, item) {
                      Room room = Room.fromMap(
                        snapshot.data!.docs[item].data()
                            as Map<String, dynamic>,
                      );
                      bool isAdmin = room.adminID.id == uid;
                      if (!isAdmin) {
                        for (var moderator in room.moderators) {
                          if (moderator.id == uid) {
                            isAdmin = true;
                            break;
                          }
                        }
                      }
                      return listItemCard(
                        roomName: room.name,
                        universityName: room.schoolName,
                        members: room.members.length.toInt(),
                        resources: room.resources.length.toInt(),
                        isPrivate: !room.isPublic,
                        method: () {
                          isAdmin
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RoomScreenAdminOrMod(
                                      room: room,
                                      uid: uid, roomId: snapshot.data!.docs[item].id,
                                    ),
                                  ),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RoomScreen(room: room, roomId: snapshot.data!.docs[item].id,),
                                  ),
                                );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
