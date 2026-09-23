import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:notehive/Screens/resourceUpload.dart';

SizedBox floatingUploadButton({
  required List categories,
  required BuildContext context,
  required String roomId,
  required bool isAdmin,
}) {
  return SizedBox(
    height: 70,
    width: 70,
    child: FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => ResourceUploadScreen(roomId: roomId,isAdmin:isAdmin,categories: <String>[...categories],)),
          ),
        );
      },
      backgroundColor: const Color(0xFF8474F0),
      child: const Icon(Icons.file_upload_rounded, color: Colors.white, size: 36),
    ),
  );
}