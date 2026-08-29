import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notehive/Screens/roomScreen.dart';
import 'package:notehive/Screens/room_announcement_page.dart';
import 'package:notehive/widgets/leadingTitleAndTailButton.dart';
import 'package:notehive/widgets/leadingbackButton.dart';

import '../Structures/roomStructure.dart';

class RoomScreenAdminOrMod extends StatefulWidget {
  final Room room;
  const RoomScreenAdminOrMod({super.key, required this.room});

  @override
  State<RoomScreenAdminOrMod> createState() => _RoomScreenAdminOrModState();
}

class _RoomScreenAdminOrModState extends State<RoomScreenAdminOrMod> {
  late bool isAdmin = widget.room.admin.name == 'Shaheer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerWidget(context),
      appBar: AppbarWidget(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Card2(), SizedBox(width: 10), Card1()],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Card3(), SizedBox(width: 10), Card4()],
              ),
              RoomCodeWidget(),
              lombaButton(context: context,text: 'View Room as a Member',method: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RoomScreen(roomName: 'Data Structure | 1205',roomSubtitle: 'AUST University',)));
              }),
              LeadingTitleAndTailButton(context: context, title: 'Pending Approvals', buttonText: '3', method: (){}),
              Text('Send Announcement',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xff352E60).withOpacity(0.1)),
                ),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write down the announcement...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Color(0xff352E60).withOpacity(0.6),
                    ),
                  ),
                ),
              ),
              lombaButton(context: context, text: 'Publish Announcement', method: (){}),
              lombaButton(context: context, text: 'View Announcement', method: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoomAnnouncementPage()));
              },bgColor: Colors.white,fgColor: Color(0xff352E60)),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton lombaButton({required BuildContext context,required String text, required VoidCallback method,Color ?bgColor,Color ?fgColor}) {
    return ElevatedButton(
            onPressed: method,

            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide(
                color: Color(0xff352E60).withOpacity(0.1),
              ),
              backgroundColor: bgColor ?? Color(0xff8474F0),
              foregroundColor: fgColor ??Colors.white,
            ),
            child: Text(text),
          );
  }

  Container RoomCodeWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xff352E60).withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'Room Code',
              style: TextStyle(
                color: Color(0xff1A1730),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Center(
            child: Text(
              'Share this code to others to let them join this room ',
              style: TextStyle(
                color: Color(0xff352E60),
                fontSize: 12,
                fontFamily: 'paragraph',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              6,
              ((index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Color(0xffF2F1FD).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xff352E60).withOpacity(0.1)),
                ),
                child: Text(
                  widget.room.roomCode[index],
                  style: TextStyle(
                    fontFamily: 'paragraph',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff352E60),
                  ),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Drawer DrawerWidget(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton.outlined(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.keyboard_arrow_right),
                iconSize: 24,
              ),
            ),
            DrawerWidgets(
              method: () {},
              text: 'Members',
              icon: Icons.people_outline_rounded,
            ),
            Divider(),
            DrawerWidgets(
              method: () {},
              text: 'Moderators',
              icon: Icons.admin_panel_settings_outlined,
            ),
            Divider(),
            DrawerWidgets(
              method: () {},
              text: 'Analytics',
              icon: Icons.auto_graph_outlined,
            ),
            Divider(),
            DrawerWidgets(
              method: () {},
              text: 'Pending Approval',
              icon: Icons.access_time,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  InkWell DrawerWidgets({
    required VoidCallback method,
    required String text,
    required IconData icon,
  }) {
    return InkWell(
      onTap: method,
      child: Row(
        children: [
          Icon(icon, size: 24),
          Text(
            '  $text',
            style: TextStyle(fontFamily: 'Paragraph', fontSize: 18),
          ),
        ],
      ),
    );
  }

  Expanded Card4() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff8474F0),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xff352E60).withOpacity(0.1)),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '04',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff6A5DC0),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(5),

                  child: Icon(
                    Icons.people_outline_rounded,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Moderators',
              style: TextStyle(
                fontFamily: 'paragraph',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'View Details ->',
              style: TextStyle(
                fontFamily: 'paragraph',
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded Card3() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xff352E60).withOpacity(0.1)),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '04',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xff352E60),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFDF1F3),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(5),

                  child: Icon(
                    Icons.delete_outline_outlined,
                    size: 25,
                    color: Color(0xffF4365F),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Removed',
              style: TextStyle(
                fontFamily: 'paragraph',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff352E60),
              ),
            ),
            Text(
              'This Week',
              style: TextStyle(
                fontFamily: 'paragraph',
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color(0xff352E60),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded Card2() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xff352E60).withOpacity(0.1)),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '12',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xff352E60),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff352E60).withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(5),

                  child: Icon(Icons.access_time, size: 25),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Pending',
              style: TextStyle(
                fontFamily: 'paragraph',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff352E60),
              ),
            ),
            Text(
              'Awaiting Review',
              style: TextStyle(
                fontFamily: 'paragraph',
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color(0xff352E60),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded Card1() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xff352E60).withOpacity(0.1)),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '14',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xff352E60),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF3FDF1),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(5),

                  child: Icon(
                    Icons.verified_outlined,
                    size: 25,
                    color: Color(0xff2E604F),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Approved Today',
              style: TextStyle(
                fontFamily: 'paragraph',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff352E60),
              ),
            ),
            Text(
              'Resources Varified',
              style: TextStyle(
                fontFamily: 'paragraph',
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color(0xff352E60),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar AppbarWidget(BuildContext context) {
    return AppBar(
      leadingWidth: 70,
      leading: LeadingBackButton(context),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isAdmin ? 'Admin Panel' : "Moderator Panel"),
          Text(
            widget.room.name,
            style: TextStyle(
              fontFamily: 'paragraph',
              fontSize: 11,
              color: Color(0xff352E60).withOpacity(.6),
            ),
          ),
        ],
      ),
      actionsPadding: EdgeInsets.only(right: 20),
      actions: [
        IconButton(
          iconSize: 30,
          onPressed: () {},
          icon: Icon(Icons.edit_note),
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
        ),
        SizedBox(width: 10),
        Builder(
          builder: (context) {
            return IconButton.outlined(
              iconSize: 30,
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: Icon(Icons.menu),
              style: IconButton.styleFrom(
                foregroundColor: Color(0xff352E60),
                backgroundColor: Colors.white,
              ),
            );
          },
        ),
      ],
    );
  }
}
