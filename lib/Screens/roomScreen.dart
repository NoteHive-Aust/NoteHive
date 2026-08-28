import 'package:flutter/material.dart';
import 'package:notehive/Screens/notifications_screen.dart';
import 'package:notehive/Screens/resourcesScreen.dart';
import 'package:notehive/widgets/AppbarWidgets.dart';
import 'package:notehive/widgets/cards.dart';
import 'package:notehive/widgets/leadingTitleAndTailButton.dart';
import 'package:notehive/widgets/leadingbackButton.dart';
import 'package:notehive/widgets/listTileForResources.dart';
import 'package:notehive/widgets/searchBox.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({
    super.key,
    required String roomName,
    required String roomSubtitle,
  });

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  List<String> categories = [
    "All",
    "Science",
    "Math",
    "English",

    "History",
    "Programming",
    "Physics",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0), // Custom corner radius
          ),
          onPressed: () {},

          backgroundColor: Color(0xFF8474F0),
          child: Icon(Icons.file_upload_rounded, color: Colors.white,size: 36,),
        ),
      ),
      appBar: AppBar(
        leadingWidth: 70,
        actionsPadding: EdgeInsets.only(right: 20),
        leading: LeadingBackButton(context),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Structure | 1205',
              style: TextStyle(
                color: Color(0xff1A1730),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Ahsanullah University of Science & Technology',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontFamily: 'paragraph',
                fontSize: 11,
                color: Color(0xff352E60).withOpacity(.6),
              ),
            ),
          ],
        ),
        actions: [NotificationButtonForAppBar(context: context)],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //SizedBox(height: 20,),
              SearchBox(lebel: 'Search for Resources'),
              SizedBox(height: 20),
              Text(
                'Categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 5),
              Wrap(
                spacing: 5,
                children: List.generate(categories.length, (index) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      iconSize: 0,
                      visualDensity: VisualDensity.compact,
                      //fixedSize: Size.fromHeight(20)
                    ),
                    onPressed: () {},
                    child: Text(categories[index]),
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
                      builder: (context) => NotificationsScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                //padding: EdgeInsets.only(top: 45, bottom: 100, left: 20, right: 20),
                itemCount: 2,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return NotificationsCard(
                    title:
                        'Mid term timetable has just been posted. Check the announcements.',
                    subtitle: 'CSE 2103',
                    time: '1h ago',
                  );
                },
              ),
              SizedBox(height: 20),
              LeadingTitleAndTailButton(
                context: context,
                title: 'Recent Resources',
                buttonText: 'See All',
                method: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ResourcesScreen()));
                },
              ),
              SizedBox(height: 10),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                //padding: EdgeInsets.only(top: 45, bottom: 100, left: 20, right: 20),
                itemCount: 3,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return ResourcesListTile(title: 'Data Structure - Unit 4',subtitle: 'CSE1203.Sem 5.Notes');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
