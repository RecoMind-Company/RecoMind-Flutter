import 'package:flutter/material.dart';

Widget buildBottomButton(String text, Color bgColor, Color textColor,  Function() ontap, {bool isBorder = false} ) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
        border: isBorder ? Border.all(color: Color(0xFF76E4FF)) : null,
      ),
      child: Center(
        child: Text(text, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    ),
  );
}
