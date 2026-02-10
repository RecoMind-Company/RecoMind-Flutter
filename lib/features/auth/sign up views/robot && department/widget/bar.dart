import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class Bar extends StatelessWidget {
  const Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Gap(8),
      customText(text: "Tables reviewed",textsize: 18,fontweight: FontWeight.w400,color: Color(0xFFB5B5B5),),
      Gap(4),
      Container(
        height: 31,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFC6C6C6),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24),bottomRight: Radius.circular(24)),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: Container(
                height: 31,
                width: 34,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF51D9FF),
                      Color(0xFF020B28),

                    ]),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(24))
                ),
              ),
            ),
            Center(child: customText(text: "1 : 12" , color: Color(0xFF060B1B),fontweight: FontWeight.bold,textsize: 18,))
          ],
        ),
      ),
    ],);
  }
}
