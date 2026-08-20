import 'package:flutter/material.dart';

Widget bottomNavigation({required int selectedIndex,
  required ValueChanged<int> onItemSelected,}){
  return Container(
    //padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10,),
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
        iconBtn(icon: Icons.home_outlined,method: (){
          onItemSelected(0);

        },isSelected: selectedIndex == 0),
        iconBtn(icon: Icons.explore_outlined,method: (){
          onItemSelected(1);
        },isSelected: selectedIndex==1),
        IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.add,),
            iconSize: 24,
            style: IconButton.styleFrom(
                backgroundColor: Color(0xFF8474F0),
                foregroundColor: Colors.white
            )
        ),
        iconBtn(icon: Icons.person_outline,method: (){
          onItemSelected(2);
        },isSelected: selectedIndex==2),
        iconBtn(icon: Icons.settings_outlined,method: (){
          onItemSelected(3);
        },isSelected: selectedIndex==3),


      ],
    ),
  );
}
Widget iconBtn({ required IconData? icon, required VoidCallback? method,required bool isSelected}){
  return GestureDetector(
    onTap: method,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children:[ Icon(
          icon,
          size: 28,
          color: Color(0xFFE6E3FC),
      ),
        SizedBox(height: 2),
      AnimatedOpacity(opacity: isSelected? 1:0
        , duration: Duration(milliseconds: 200),
        child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle,
        )
      ),)
      ]
    ),
  );
}