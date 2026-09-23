import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notehive/FirebaseOperations/getNotifications.dart';
import '../widgets/cards.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String getTimeAgo(DateTime time) {
    Duration diff = DateTime.now().difference(time);
    if (diff.inDays >= 1) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
          future: getNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No notifications found.'));
            }
            var docs = snapshot.data!;
            return ListView.separated(
              padding: EdgeInsets.only(top: 45, bottom: 100, left: 20, right: 20),
              itemCount: docs.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 15,
                );
              },
              itemBuilder: (context, index) {
                var data = docs[index].data()!;
                DateTime uploadTime = (data['UploadTime'] is Timestamp)
                    ? (data['UploadTime'] as Timestamp).toDate()
                    : DateTime.now();
                return NotificationsCard(
                  title: data['Content'] ?? '',
                  subtitle: data['RoomName'] ?? '',
                  time: getTimeAgo(uploadTime),
                );
              },
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
