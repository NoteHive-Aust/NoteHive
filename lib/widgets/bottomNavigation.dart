import 'package:flutter/material.dart';

Widget bottomNavigation(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10,),
    width: 320,
    height: 60,
    margin: EdgeInsets.only(bottom: 25),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: Color(0xFF0D0C18)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        iconBtn(icon: Icons.home_outlined,method: (){}),
        iconBtn(icon: Icons.explore_outlined,method: (){}),
        IconButton(
            onPressed: (){
              print("Hello");
            },
            icon: Icon(Icons.add,),
            iconSize: 24,
            style: IconButton.styleFrom(
                backgroundColor: Color(0xFF8474F0),
                foregroundColor: Colors.white
            )
        ),
        iconBtn(icon: Icons.person_outline,method: (){
          print("object");
        }),
        iconBtn(icon: Icons.settings_outlined,method: (){}),


      ],
    ),
  );
}
Widget iconBtn({IconData? icon,VoidCallback? method}){
  return IconButton(
      iconSize: 24,
      onPressed: method,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        //backgroundColor: Color(0xFF8474F0),
          foregroundColor: Color(0xFFE6E3FC)
      )
  );
}