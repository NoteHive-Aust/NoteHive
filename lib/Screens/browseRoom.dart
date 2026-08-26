import 'package:flutter/material.dart';
import 'package:notehive/Screens/joinRoom.dart';
import 'package:notehive/widgets/AppbarWidgets.dart';
import 'package:notehive/widgets/listTileForBrowseRoom.dart';
import 'package:notehive/widgets/searchBox.dart';

class Browseroom extends StatefulWidget {
  const Browseroom({super.key});

  @override
  State<Browseroom> createState() => _BrowseroomState();
}

class _BrowseroomState extends State<Browseroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 40,left: 20,right: 20,bottom: 10),
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
                    Flexible(child: SearchBox(lebel: 'Search for room')),
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
            child: ListView.separated(
              padding:EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: 15,
              itemBuilder: (context, index) {
                return listTileforBrowseRoom(context: context,title: 'Data Structure | 1205',member: 15);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10);
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
      actions: [NotificationButtonForAppBar(context: context)],
    );
  }
}
