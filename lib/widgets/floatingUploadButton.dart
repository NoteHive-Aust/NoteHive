

import 'package:flutter/material.dart';
import 'package:notehive/Screens/resourceUpload.dart';

SizedBox floatingUploadButton({required BuildContext context}) {
  return SizedBox(
    height: 70,
    width: 70,
    child: FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0), // Custom corner radius
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: ((context) => ResourceUploadScreen())));
      },

      backgroundColor: Color(0xFF8474F0),
      child: Icon(Icons.file_upload_rounded, color: Colors.white,size: 36,),
    ),
  );
}