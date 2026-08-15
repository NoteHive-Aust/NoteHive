import 'package:flutter/material.dart';
import '../widgets/bottomNavigation.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 100, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: double.infinity),
                  SizedBox(height: 56),
                  CircleAvatar(radius: 60, child: Icon(Icons.person, size: 80)),
                  SizedBox(height: 20),
                  Text(
                    'Student Name',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1730),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Ahsanullah University of Science & Technology',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF352E60).withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: 20),
                  infoCard(
                    email: 'student@gmail.com',
                    totalUploads: '34',
                    repPoints: '1,200',
                    rooms: '4',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  titleMaker(
                    label: 'Joined Rooms'
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  joinedRoomCard(roomName: 'Box er Class', members: 130),
                  SizedBox(
                    height: 10,
                  ),
                  joinedRoomCard(roomName: 'Box er Class', members: 130),
                  SizedBox(
                    height: 10,
                  ),
                  joinedRoomCard(roomName: 'Box er Class', members: 130),
                  SizedBox(
                    height: 40,
                  ),
                  titleMaker(
                    label: 'My Uploads',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  myUploadsCard(
                    title: 'DS Question Bank',
                    subtitle: 'CSE 2103. Fall2025. Question Bank'
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  myUploadsCard(
                      title: 'DS Question Bank',
                      subtitle: 'CSE 2103. Fall2025. Question Bank'
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  myUploadsCard(
                      title: 'DS Question Bank',
                      subtitle: 'CSE 2103. Fall2025. Question Bank'
                  ),
                ],
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNavigation())
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 150,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset('assets/logo.png'),
      ),
      actionsPadding: EdgeInsets.only(right: 20),
      actions: [
        IconButton(
          iconSize: 30,
          onPressed: () {},
          icon: Icon(Icons.edit_outlined),
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
        ),
        SizedBox(width: 10),
        IconButton.outlined(
          iconSize: 30,
          onPressed: () {},
          icon: Icon(Icons.notifications_none),
          style: IconButton.styleFrom(
            foregroundColor: Color(0xFF1A1730),
            //backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget infoCard({
    required String email,
    required String totalUploads,
    required String repPoints,
    required String rooms,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF352E60).withOpacity(0.1),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        children: [
          infoMaker('Email', email),
          Divider(
            height: 1,
            thickness: 1,
            indent: 18,
            endIndent: 18,
            color: Color(0xFF352E60).withOpacity(0.08),
          ),
          infoMaker('Total Uploads', totalUploads),
          Divider(
            height: 1,
            thickness: 1,
            indent: 18,
            endIndent: 18,
            color: Color(0xFF352E60).withOpacity(0.08),
          ),
          infoMaker('Rep Points', repPoints),
          Divider(
            height: 1,
            thickness: 1,
            indent: 18,
            endIndent: 18,
            color: Color(0xFF352E60).withOpacity(0.08),
          ),
          infoMaker('Rooms', rooms),
        ],
      ),
    );
  }

  Widget infoMaker(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A1730),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFF352E60).withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleMaker({required String label}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1730),
          ),
        ),
        Container(
         height: 20, width: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF352E60).withOpacity(0.1),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(120),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              'See All',
              style: TextStyle(
                fontSize: 9.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget joinedRoomCard({required String roomName, required int members}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF352E60).withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            roomName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1730),
            ),
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.people_outline,
                size: 16,
                color: Color(0xFF352E60).withOpacity(0.6),
              ),
              SizedBox(width: 4),
              Text(
                "$members Members",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF352E60).withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myUploadsCard({required String title, required String subtitle}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF352E60).withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFE6E3FC).withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.description_outlined,
              size: 20,
              color: Color(0xFF352E60),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1730),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF352E60).withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 24,
            color: Color(0xFF1A1730),
          ),
        ],
      ),
    );
  }
}
