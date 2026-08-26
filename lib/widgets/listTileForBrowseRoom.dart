import 'package:flutter/material.dart';
import 'package:notehive/Screens/joinRoom.dart';

Container listTileforBrowseRoom({required BuildContext context,required String title,required double member}) {
  return Container(
    // margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      border: Border.all(
        color: Color(0xff352E60).withOpacity(0.1),
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xff1A1730),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(Icons.people_alt_outlined, size: 16),
          SizedBox(width: 5),
          Text(
            ' ${member.round()} ',
            style: TextStyle(
              color: Color(0xff352E60),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Members',
            style: TextStyle(
              color: Color(0xff352E60).withOpacity(0.6),
            ),
          ),
        ],
      ),

      trailing: OutlinedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Joinroom()));
        },
        style: OutlinedButton.styleFrom(
          overlayColor: Color(0xff8474F0),
          side: BorderSide(
            color: Color(0xff352E60).withOpacity(0.1),
          ),
          visualDensity: VisualDensity.compact,
          // fixedSize: Size(75,25)
        ),
        child: Text(
          "Join",
          style: TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      style: ListTileStyle.drawer,
    ),
  );
}