import "package:flutter/material.dart";

IconButton NotificationButtonForAppBar() {
  return IconButton.outlined(
    iconSize: 30,
    onPressed: () {},
    icon: Icon(Icons.notifications_none),
    style: IconButton.styleFrom(
      foregroundColor: Color(0xFF1A1730),
      //backgroundColor: Colors.white,
    ),
  );
}
