import "package:flutter/material.dart";
import "package:notehive/Screens/notifications_screen.dart";

IconButton NotificationButtonForAppBar({required BuildContext context}) {
  return IconButton.outlined(
    iconSize: 30,
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationsScreen()),
      );
    },
    icon: Icon(Icons.notifications_none),
    style: IconButton.styleFrom(
      foregroundColor: Color(0xFF1A1730),
      overlayColor: Color(0xff8474F0),
      //backgroundColor: Colors.white,
    ),
  );
}