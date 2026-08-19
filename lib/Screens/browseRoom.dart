import 'package:flutter/material.dart';
import 'package:notehive/widgets/AppbarWidgets.dart';
import 'package:notehive/widgets/searchBox.dart';
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
      appBar: Appbar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
            Text(
              "Browse Rooms",
              style: TextStyle(
                fontSize: 40,
                color: Color(0xff1A1730),
                fontWeight: FontWeight.w500,
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
            Expanded(
              child: ListView.separated(
                itemCount:15,
                itemBuilder: (context, index) {
                  return Container(
                    // margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff352E60).withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: ListTile(
                      title: Text(
                        'Data Structure | 1205',
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
                            '15 ',
                            style: TextStyle(
                              color: Color(0xff352E60),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Members',
                            style: TextStyle(
                              color: Color(0xff352E60).withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),

                      trailing: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          "Join",
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        style: OutlinedButton.styleFrom(
                          overlayColor: Color(0xff8474F0),
                          side: BorderSide(
                            color: Color(0xff352E60).withOpacity(0.1),
                          ),
                          visualDensity: VisualDensity.compact,
                          // fixedSize: Size(75,25)
                        ),
                      ),
                      style: ListTileStyle.drawer,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
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
      actions: [NotificationButtonForAppBar()],
    );
  }
}
