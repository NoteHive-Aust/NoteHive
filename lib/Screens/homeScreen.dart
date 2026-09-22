import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notehive/FirebaseOperations/getMyRooms.dart';
import 'package:notehive/Screens/RoomScreen_adminOrMod.dart';
import 'package:notehive/Screens/notifications_screen.dart';
import 'package:notehive/Screens/roomScreen.dart';
import 'package:notehive/Screens/searchMyRooms.dart';
import 'package:notehive/Structures/roomStructure.dart';
import 'package:notehive/Structures/userStructure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notehive/widgets/listitemcardforhome.dart';
import '../widgets/AppbarWidgets.dart';
import '../widgets/bottomNavigation.dart';

class Homescreen extends StatefulWidget {
  final User? user;
  const Homescreen({super.key,required this.user});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String uid = FirebaseAuth.instance.currentUser!.uid;



  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),
            Text(
              "My Rooms",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1730),
              ),
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: getMyRooms(uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No documents found.'));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, item) {
                        Room room = Room.fromMap(
                          snapshot.data!.docs[item].data(),
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
                                      builder: (context) =>
                                          RoomScreenAdminOrMod(
                                            room: room,
                                            uid: uid,
                                            roomId:
                                                snapshot.data!.docs[item].id,
                                          ),
                                    ),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RoomScreen(
                                        room: room,
                                        roomId: snapshot.data!.docs[item].id,
                                      ),
                                    ),
                                  );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar Appbar() {
    return AppBar(
      leadingWidth: 60,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: CircleAvatar(
          maxRadius: 25,
          minRadius: 20,
          foregroundImage: widget.user == null
              ? AssetImage('assets/image.jpg')
              : NetworkImage(widget.user!.profileUrl),
        ),
      ),
      title: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user==null? 'Name Loading':widget.user!.name,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF352E60),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.user==null?'loading...':widget.user!.schoolName,
              style: TextStyle(fontSize: 12, color: Color(0xFF352E60)),
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(right: 20),
      actions: [
        IconButton(
          iconSize: 30,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchMyRooms()),
            );
          },
          icon: Icon(Icons.search),
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
        ),
        SizedBox(width: 10),
        NotificationButtonForAppBar(
          context: context,
          screen: NotificationsScreen(),
        ),
      ],
    );
  }
}
