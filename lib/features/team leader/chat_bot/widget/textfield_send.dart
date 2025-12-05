import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';



class TextfieldSend extends StatelessWidget {
  const TextfieldSend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 25),
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            width: 279,
            // شيل height هنا عشان يخلي الـ TextField يكبر
            child: TextField(
              maxLines: null,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: "Type your message here...",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF7F7F7F),
                ),
                fillColor: Color(0xFF3C3E45),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ),
          Gap(10),
          Icon(CupertinoIcons.mic,color: Color(0xFF7F7F7F),size: 30,),
          Gap(10),
          Container(
              width: 40,
              height: 40,
              child: SvgPicture.asset("assets/Team leader svg/send.svg"))
        ],
      ),
    );
  }
}
