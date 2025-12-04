import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class InputEmail extends StatelessWidget {
  const InputEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: TextField(
        style: TextStyle(color:Color(0xffeeeeee) ) ,

        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(

            hintText: "Enter Your Email",
            hintStyle: TextStyle(color:Color(0xffB8ADAD) ,fontSize: 14),
            contentPadding: EdgeInsets.symmetric(vertical:20),
            prefixIcon:Padding(padding: EdgeInsetsGeometry.only(left: 20,right: 15),
              child: Icon(LucideIcons.mail , color: Color(0xffeeeeee),size: 28) ,) ,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffeeeeee),width: 2),
                borderRadius: BorderRadius.circular(10)
            ),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffeeeeee),width: 2),
                borderRadius: BorderRadius.circular(10))

        ),

      ),
    );
  }
}
