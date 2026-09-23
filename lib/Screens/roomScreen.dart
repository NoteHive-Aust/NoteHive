import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notehive/FirebaseOperations/getAnnouncemnets.dart';
import 'package:notehive/FirebaseOperations/getRoomResources.dart';
import 'package:notehive/Screens/notifications_screen.dart';
import 'package:notehive/Screens/resourcesScreen.dart';
import 'package:notehive/Screens/room_announcement_page.dart';
import 'package:notehive/Structures/announcements.dart';
import 'package:notehive/Structures/resourcesStructure.dart';
import 'package:notehive/Structures/roomStructure.dart';
import 'package:notehive/widgets/AppbarWidgets.dart';
import 'package:notehive/widgets/cards.dart';
import 'package:notehive/widgets/leadingTitleAndTailButton.dart';
import 'package:notehive/widgets/leadingbackButton.dart';
import 'package:notehive/widgets/listTileForResources.dart';
import 'package:notehive/widgets/searchBox.dart';

import '../widgets/floatingUploadButton.dart';

class RoomScreen extends StatefulWidget {
  final Room room;
  final String roomId;
  const RoomScreen({super.key, required this.room, required this.roomId});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  bool isModeratorUpload = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    if (widget.room.onlyModeratorUpload) {
      for (var moderator in widget.room.moderators) {
        if (moderator.id == uid) {
          isModeratorUpload = true;
          break;
        }
      }
    } else {
      isModeratorUpload = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isModeratorUpload
          ? floatingUploadButton(
              context: context,
              roomId: widget.roomId,
              isAdmin: false,
              categories: widget.room.categories,
            )
          : null,
      appBar: AppBar(
        leadingWidth: 70,
        actionsPadding: EdgeInsets.only(right: 20),
        leading: LeadingBackButton(context),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.room.name,
              style: TextStyle(
                color: Color(0xff1A1730),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              widget.room.schoolName,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontFamily: 'paragraph',
                fontSize: 11,
                color: Color(0xff352E60).withOpacity(.6),
              ),
            ),
          ],
        ),
        actions: [
          NotificationButtonForAppBar(
            context: context,
            screen: RoomAnnouncementPage(roomId: widget.roomId),
          ),
          SizedBox(width: 5),
          IconButton.outlined(
            iconSize: 30,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Are you sure you want to leave this room?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(uid)
                              .update({
                                'MemberAt': FieldValue.arrayRemove([
                                  FirebaseFirestore.instance
                                      .collection('Rooms')
                                      .doc(widget.roomId),
                                ]),
                              });
                          await FirebaseFirestore.instance
                              .collection('Rooms')
                              .doc(widget.roomId)
                              .update({
                                'Members': FieldValue.arrayRemove([
                                  FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(uid),
                                ]),
                              })
                              .then((value) {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              });
                        },
                        child: Text('Leave'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.logout_sharp),
            style: IconButton.styleFrom(
              foregroundColor: Colors.deepOrange[300],
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //SizedBox(height: 20,),
              SearchBox(
                lebel: 'Search for Resources',
                controller: TextEditingController(),
                onChanged: () {},
              ),
              SizedBox(height: 20),
              Text(
                'Categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 5),
              Wrap(
                spacing: 5,
                children: List.generate(widget.room.categories.length, (index) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      iconSize: 0,
                      visualDensity: VisualDensity.compact,
                      //fixedSize: Size.fromHeight(20)
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ResourcesScreen(
                            roomId: widget.roomId,
                            room: widget.room,
                            filtered: widget.room.categories[index],
                          ),
                        ),
                      );
                    },
                    child: Text(widget.room.categories[index]),
                  );
                }),
              ),
              SizedBox(height: 20),
              LeadingTitleAndTailButton(
                context: context,
                title: 'Annoucements',
                buttonText: 'See All',
                method: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RoomAnnouncementPage(roomId: widget.roomId),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              FutureBuilder(
                future: getAnnouncement(roomId: widget.roomId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length > 2
                        ? 2
                        : snapshot.data!.docs.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      var notification = Notifications.fromMap(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>,
                      );
                      return NotificationsCard(
                        title: notification.content,
                        subtitle: notification.roomName,
                        time:
                            '${DateTime.now().difference(notification.uploadTime).inHours}h ago',
                      );
                    },
                  );
                },
              ),

              SizedBox(height: 20),
              LeadingTitleAndTailButton(
                context: context,
                title: 'Recent Resources',
                buttonText: 'See All',
                method: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResourcesScreen(
                        room: widget.room,
                        roomId: widget.roomId,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              FutureBuilder(
                future: getRoomResources(roomId: widget.roomId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    //padding: EdgeInsets.only(top: 45, bottom: 100, left: 20, right: 20),
                    itemCount: snapshot.data!.docs.length > 3
                        ? 3
                        : snapshot.data!.docs.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      return ResourcesListTile(
                        context: context,
                        resource: Resource.fromMap(
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>,
                        ),
                        resourceID: snapshot.data!.docs[index].id,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
