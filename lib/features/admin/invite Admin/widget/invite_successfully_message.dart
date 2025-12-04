import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/custom_text.dart';



class InviteSuccessfullyMessage extends StatelessWidget {
  const InviteSuccessfullyMessage({super.key,required this.ontap});
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.transparent.withOpacity(0.2),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50,vertical: 323),

          decoration: BoxDecoration(
            color: Color(0xFF060B1B),
            borderRadius: BorderRadius.circular(15),

          ),
          child: Column(
              children: [
                Gap(51),
                customText(text: "Email invitation sent successfully",color: Color(0xFFEEEEEE),fontweight: FontWeight.w700,textsize: 16,),
                Gap(32),
                Divider(
                  color: Color(0xFF03294A),
                  thickness: 1,),
                GestureDetector(
                  onTap: ontap,
                  child:Container(
                    color: Color(0xFF060B1B),
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: customText(text: "Done",
                        color: Color(0xFF3BD574),
                        fontweight: FontWeight.w500,
                        textsize: 20,),
                  )
                )
              ],
          ),
        ),
      ),
    );
  }
}
