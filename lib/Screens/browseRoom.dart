import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notehive/FirebaseOperations/SearchRooms.dart';
import 'package:notehive/Screens/joinRoom.dart';
import 'package:notehive/Screens/notifications_screen.dart';
import 'package:notehive/Structures/roomStructure.dart';
import 'package:notehive/widgets/AppbarWidgets.dart';
import 'package:notehive/widgets/listTileForBrowseRoom.dart';
import 'package:notehive/widgets/searchBox.dart';

class Browseroom extends StatefulWidget {
  const Browseroom({super.key});

  @override
  State<Browseroom> createState() => _BrowseroomState();
}

class _BrowseroomState extends State<Browseroom> {
  Timer? waitforUserToStopTyping;
  String uid = "abcw";
  final TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> getRoomsfilted() async {
    String searchText = _searchController.text.trim();
    if (searchText.isEmpty) {
      return fetchAvailableRooms(uid);
    } else {
      return await FirebaseFirestore.instance
          .collection('Rooms')
          .where('Name', isGreaterThanOrEqualTo: searchText)
          .where('Name', isLessThanOrEqualTo: searchText + '\uf8ff')
          // .where('RoomCode', isGreaterThanOrEqualTo: searchText)
          // .where('RoomCode', isLessThanOrEqualTo: searchText + '\uf8ff')
          .limit(5)
          .get();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Browse Rooms",
                  style: TextStyle(
                    fontSize: 40,
                    //color: Color(0xff1A1730),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: SearchBox(
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
                    ),
                    IconButton.filled(
                      onPressed: () {},
                      icon: Icon(Icons.filter_list),
                      style: IconButton.styleFrom(
                        backgroundColor: Color(0xff8474F0),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: getRoomsfilted(),
              builder: (context, Snapshot) {
                if (Snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }
                if (Snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (Snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No Public rooms found.'));
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: Snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Room roomData = Room.fromMap(
                      Snapshot.data!.docs[index].data() as Map<String, dynamic>,
                    );
                    return listTileforBrowseRoom(
                      context: context,
                      room: Snapshot.data!.docs[index],
                      uid: uid,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      leadingWidth: 60,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: CircleAvatar(
          maxRadius: 25,
          minRadius: 20,
          foregroundImage: AssetImage('assets/image.jpg'),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sheikh Hasina",
            style: TextStyle(
              fontFamily: 'paragraph',
              fontSize: 16,
              color: Color(0xFF352E60),
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "NUET",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF352E60),
              fontWeight: FontWeight.normal,
              fontFamily: 'paragraph',
            ),
          ),
        ],
      ),
      actionsPadding: EdgeInsets.only(right: 20),
      actions: [
        NotificationButtonForAppBar(
          context: context,
          screen: NotificationsScreen(),
        ),
      ],
    );
  }
}
