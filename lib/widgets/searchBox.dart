import 'package:flutter/material.dart';

Container SearchBox({required String lebel}) {
  return Container(
    height: 55,
    margin: EdgeInsets.symmetric(vertical: 20),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: Color(0xff352E60).withOpacity(0.05),
    ),
    child: TextField(
      maxLines: 1,
      decoration: InputDecoration(
        border: InputBorder.none,

        icon: Icon(Icons.search),
        hintText: lebel,
      ),
    ),
  );
}