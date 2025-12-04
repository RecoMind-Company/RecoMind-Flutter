import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class PremiumCard extends StatelessWidget {
  const PremiumCard(
      {super.key,
      required this.title,
      required this.text1,
      required this.text2,
      required this.text3,
        required this.text4,
        required this.text5,
        required this.text6,
      });

  final String title;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: const AssetImage("assets/Team_Leader/home/Prime.png"),
          height: 210,
        ),
        Positioned(
          top: 20,
          left: 20,
          child: customText(
            text: title,
              textsize: 18,
              color: Colors.white,
              fontweight: FontWeight.w500,
          ),
        ),
        Positioned(
          top: 70,
          left: 20,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Image(
                  image: const AssetImage("assets/Team_Leader/home/star2.png"),
                  height: 20,
                ),
              ),
              Gap(6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: text1,
                          textsize: 12,
                          color: Color(0xFF96E8FF),
                          fontweight: FontWeight.w500,
                      ),Gap(3),
                      customText(
                        text: text2,
                          textsize: 12,
                          color: Colors.white,
                          fontweight: FontWeight.w500,
                      ),
                    ],
                  ),
                  customText(
                    text: text3,
                    textsize: 12,
                    color: Colors.white,
                    fontweight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 40,
          left: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Image(
                  image: const AssetImage("assets/Team_Leader/home/star2.png"),
                  height: 20,
                ),
              ),
              Gap(6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: text4,
                        textsize: 12,
                        color: Color(0xFF96E8FF),
                        fontweight: FontWeight.w500,
                      ),Gap(3),
                      customText(
                        text: text5,
                        textsize: 12,
                        color: Colors.white,
                        fontweight: FontWeight.w500,
                      ),
                    ],
                  ),
                  customText(
                    text: text6,
                    textsize: 12,
                    color: Colors.white,
                    fontweight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right:40,
            bottom:30 ,
            child: Image.asset("assets/Team_Leader/home/list.png")),
      ],
    );
  }
}
