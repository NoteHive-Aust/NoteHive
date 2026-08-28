import 'package:flutter/material.dart';

Row LeadingTitleAndTailButton({required BuildContext context,required String title,required String buttonText,required VoidCallback method}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title,style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),),
      OutlinedButton(onPressed:
        method
      , child: Text(buttonText))
    ],
  );
}
