import 'package:flutter/material.dart';
import 'profile_screen.dart'; //for the myUploadsCard. might change later by putting that card into different dart file :3

class MyUploads extends StatefulWidget {
  const MyUploads({super.key});

  @override
  State<MyUploads> createState() => _MyUploadsState();
}

class _MyUploadsState extends State<MyUploads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 100, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity),
              SizedBox(height: 45),
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
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 70,
      titleSpacing: 10,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton.outlined(
          iconSize: 30,
          onPressed: () {},
          icon: Icon(Icons.chevron_left),
          style: IconButton.styleFrom(
            foregroundColor: Color(0xFF1A1730),
            shape: const CircleBorder(),
          ),
        ),
      ),
      title: Text(
        'My Uploads',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1A1730),
        ),
      ),
    );
  }

  Widget myUploadsCard({required String title, required String subtitle}) {
    return Container(
      width: double.infinity,
      height: 70,
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
