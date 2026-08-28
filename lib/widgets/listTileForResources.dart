import 'package:flutter/material.dart';

ListTile ResourcesListTile({required String title,required String subtitle}) {
  return ListTile(
    onTap: (){},
    trailing: Icon(Icons.chevron_right, size: 34),
    leading: Icon(Icons.description_outlined, size: 34),
    title: Text(title),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(subtitle),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 2,
              ),
              // height: 16,
              // width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
                border: Border.all(
                  color: Color(0xff352E60).withOpacity(0.6),
                ),
              ),

              //padding: EdgeInsets.all(5),
              child: Center(
                child: Text(
                  'Notes',
                  style: TextStyle(
                    fontFamily: 'paragraph',
                    fontSize: 12,
                    color: Color(0xff352E60),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            SizedBox(width: 5),
            Text(
              'By Mushfiq',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff352E60),
              ),
            ),
          ],
        ),
      ],
    ),
    //isThreeLine: true,
  );
}