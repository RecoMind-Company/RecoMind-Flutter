import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/diver_wid.dart';

class ExpandScreen extends StatelessWidget {
  const ExpandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Gap(90),
              Row(
                children: [
                  Gap(15),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                        size: 30,
                      )),
                ],
              ),
              Gap(40),

              /// title
              Row(
                children: [
                  customText(
                    text: "Your insights and action plan are\nready",
                    textsize: 20,
                    fontweight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ],
              ),
              Gap(16),
              Container(
                height: 505,
                width: 349,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0.001, 5, 5],
                      begin: AlignmentGeometry.bottomLeft,
                      end: AlignmentGeometry.topRight,
                      colors: [
                        Color(0xFFD9D9D9),
                        Color(0xFF02112F),
                        Color(0xFF02112F)
                      ]),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              ///Divider
              Gap(32),
              Divider(
                color: Color(0xFF7EE3FF),
                thickness: 0.7,
              ),
              Gap(32),

              /// title
              Row(
                children: [
                  customText(
                    text: "Your Plan",
                    textsize: 20,
                    fontweight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ],
              ),
              Gap(16),
              Container(
                height: 323,
                width: 349,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0.001, 5, 5],
                      begin: AlignmentGeometry.bottomLeft,
                      end: AlignmentGeometry.topRight,
                      colors: [
                        Color(0xFFD9D9D9),
                        Color(0xFF02112F),
                        Color(0xFF02112F)
                      ]),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Gap(30)
            ],
          ),
        ),
      )),
    );
  }
}
