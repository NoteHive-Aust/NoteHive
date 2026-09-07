import 'package:flutter/material.dart';
import 'package:notehive/Screens/moderators.dart';
import '../widgets/cards.dart';

class RoomAnnouncementPage extends StatefulWidget {
  const RoomAnnouncementPage({super.key});

  @override
  State<RoomAnnouncementPage> createState() => _RoomAnnouncementPageState();
}

class _RoomAnnouncementPageState extends State<RoomAnnouncementPage> {
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
            return SizedBox(
              height: 15,
            );
          },
          itemBuilder: (context, index) {
            return NotificationsCard(
              title:
                  'Mid term timetable has just been posted. Check the announcements.',
              subtitle: '',
              time: '1h ago',
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
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.chevron_left),
          style: IconButton.styleFrom(
            foregroundColor: Color(0xFF1A1730),
            shape: const CircleBorder(),
          ),
        ),
      ),
      title: Text(
        'Announcements',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1A1730),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: PopupMenuButton<String>(
            icon: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFF352E60).withOpacity(0.1),
                ),
              ),
              child: Icon(
                Icons.more_vert,
                color: Color(0xFF1A1730),
                size: 20,
              ),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onSelected: (value) {
              if (value == 'moderators') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ModeratorsScreen()),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'moderators',
                child: Row(
                  children: [
                    Icon(
                      Icons.admin_panel_settings_outlined,
                      color: Color(0xFF1A1730),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Moderators',
                      style: TextStyle(
                        color: Color(0xFF1A1730),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
