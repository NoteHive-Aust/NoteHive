

import 'package:flutter/material.dart';

SizedBox floatingUploadButton() {
  return SizedBox(
    height: 70,
    width: 70,
    child: FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0), // Custom corner radius
      ),
      onPressed: () {},

      backgroundColor: Color(0xFF8474F0),
      child: Icon(Icons.file_upload_rounded, color: Colors.white,size: 36,),
    ),
  );
}