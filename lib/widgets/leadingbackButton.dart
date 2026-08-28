
import 'package:flutter/material.dart';

IconButton LeadingBackButton(BuildContext context) {
  return IconButton.outlined(
    iconSize: 30,
    onPressed: () {
      Navigator.of(context).pop();
    },
    icon: Icon(Icons.chevron_left),
    style: IconButton.styleFrom(
      foregroundColor: Color(0xFF1A1730),
      shape: const CircleBorder(),
    ),
  );
}