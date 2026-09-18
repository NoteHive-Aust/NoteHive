 import 'package:flutter/material.dart';

Card listItemCard({
    required String roomName,
    required String universityName,
    required int members,
    required int resources,
    required bool isPrivate,
    required VoidCallback method,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Color(0xFF352E60).withOpacity(.1)),
      ),
      child: ListTile(
        onTap: method,

        //tileColor: Colors.white,
        title: Text(roomName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(universityName),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.people_outline, size: 16),
                    SizedBox(width: 5),
                    Text(
                      members.toString(),
                      style: TextStyle(
                        //ontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff352E60),
                      ),
                    ),
                    Text(" Members"),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Icon(Icons.insert_drive_file_outlined, size: 16),
                    Text(
                      resources.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff352E60),
                      ),
                    ),
                    Text(" Resources", style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color(0xFF352E60).withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.circular(200),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      isPrivate
                          ? Icon(Icons.lock_outline_rounded, size: 12)
                          : Icon(Icons.lock_open_rounded, size: 12),
                      SizedBox(width: 2),
                      Text(
                        " ${isPrivate ? "Private" : "Public"}",
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }