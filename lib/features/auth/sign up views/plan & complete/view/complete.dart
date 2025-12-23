import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/root.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class completesetup extends StatefulWidget {
  const completesetup({super.key});

  @override
  State<completesetup> createState() => _completesetupState();
}

class _completesetupState extends State<completesetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Containerwid(
      child: Column(
        children: [
          Gap(73),
          Container(
              child: customText(
            text: "Setup Complete!",
                textsize: 28,
                color: Color(0xffEEEEEE),
                fontweight: FontWeight.bold),
          ),
          Gap(40),
          Image(image: AssetImage("assets/complete.png")),
          Gap(40),
          Container(
              alignment: Alignment.center,
              child: customText(
                text: "Let’s make your company thrive!",
                  textsize: 25,
                  color: Color(0xffEEEEEE),
                  fontweight: FontWeight.bold,
                iscenter: true,
              )),
         Gap(40),
          MaterialButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => root(Role: "admin",),), (Route<dynamic> route) => false,);
              },
              child: Container(
                  width: 330,
                  height: 50,
                  alignment: Alignment.center,
                  child: customText(
                   text: "Get Started",
                        textsize: 16,
                        color: Color(0xff070C1E),
                        fontweight: FontWeight.w700),
                  ),
              color: Color(0xFF7EE3FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ))
        ],
      ),
    ));
  }
}
