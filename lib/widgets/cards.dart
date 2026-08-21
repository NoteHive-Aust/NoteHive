import 'package:flutter/material.dart';

class JoinedRoomCard extends StatelessWidget {
  final String roomName;
  final int members;
  final VoidCallback method;

  const JoinedRoomCard({
    super.key,
    required this.roomName,
    required this.members,
    required this.method,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: method,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Color(0xFF352E60).withOpacity(0.1)),
      ),
      tileColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(
        roomName,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1730),
        ),
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
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
    );
  }
}

class MyUploadsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback method;

  const MyUploadsCard({super.key, required this.title, required this.subtitle, required this.method});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: method,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Color(0xFF352E60).withOpacity(0.1)),
      ),
      tileColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
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
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1730),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFF352E60).withOpacity(0.6),
        ),
      ),
      trailing: Icon(Icons.chevron_right, size: 24, color: Color(0xFF1A1730)),
    );
  }
}

class NotificationsCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String time;

  const NotificationsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  State<NotificationsCard> createState() => _NotificationsCardState();
}

class _NotificationsCardState extends State<NotificationsCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFFE6E3FC).withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.notifications_none,
          size: 20,
          color: Color(0xFF352E60),
        ),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1730),
        ),
      ),
      subtitle: Text(
        widget.subtitle,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Color(0xFF1A1730),
        ),
      ),
      trailing: Text(
        widget.time,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Color(0xFF1A1730),
        ),
      ),
    );
  }
}
