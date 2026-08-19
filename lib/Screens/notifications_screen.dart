import 'package:flutter/material.dart';
import '../widgets/cards.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.only(top: 45, bottom: 100, left: 20, right: 20),
          itemCount: 10,
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              thickness: 1,
              indent: 18,
              endIndent: 18,
              color: Color(0xFF352E60).withOpacity(0.08),
            );
          },
          itemBuilder: (context, index) {
            return NotificationsCard(title: 'Mid term timetable has just been posted. Check the announcements.',
            subtitle: 'CSE 2103', time: '1h ago');
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
        'Notifications',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1A1730),
        ),
      ),
    );
  }
}
