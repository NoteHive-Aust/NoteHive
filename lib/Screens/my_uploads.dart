import 'package:flutter/material.dart';
import '../widgets/cards.dart';

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
        child: ListView.separated(
          padding: EdgeInsets.only(top: 45, bottom: 100, left: 20, right: 20),
          itemCount: 10,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            return MyUploadsCard(
              title: 'DS Question Bank',
              subtitle: 'CSE 2103. Fall2025. Question Bank',
            );
          },
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

}
