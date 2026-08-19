import 'package:flutter/material.dart';

import '../widgets/AppbarWidgets.dart';
import '../widgets/bottomNavigation.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                Text(
                  "My Rooms",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1730),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, item) {
                      return listItemCard(roomName: 'Box er Class',
                          universityName: 'AUST University',
                          members: 102,
                          resources: 20,
                          isPrivate: false,
                          method: () {});
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNavigation()),
        ],
      ),
    );
  }

  Card listItemCard({
    required String roomName,
    required String universityName,
    required int members,
    required int resources,
    required bool isPrivate,
    required VoidCallback method,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Color(0xFF352E60).withOpacity(.1)),
      ),
      child: ListTile(
        onTap: method,
        splashColor: Color(0xFFE6E3FC).withOpacity(0.7),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        //tileColor: Colors.white,
        title: Text(
          roomName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1730),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(universityName, style: TextStyle(fontSize: 14)),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.people_outline, size: 16),
                    SizedBox(width: 5),
                    Text(
                      members.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(" Members", style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Icon(Icons.insert_drive_file_outlined, size: 16),
                    Text(
                      resources.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(" Resources", style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(width: 10),
                Container(
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
                      isPrivate
                          ? Icon(Icons.lock_outline_rounded, size: 12)
                          : Icon(Icons.lock_open_rounded, size: 12),
                      SizedBox(width: 2),
                      Text(" ${isPrivate ? "Private" : "Public"}",
                          style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ],
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
          foregroundImage: AssetImage('assets/image.jpg'),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sheikh Hasina",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF352E60),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "NUET",
            style: TextStyle(fontSize: 12, color: Color(0xFF352E60)),
          ),
        ],
      ),
      actionsPadding: EdgeInsets.only(right: 20),
      actions: [
        IconButton(
          iconSize: 30,
          onPressed: () {},
          icon: Icon(Icons.search),
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
        ),
        SizedBox(width: 10),
        NotificationButtonForAppBar(),
      ],
    );
  }

}
