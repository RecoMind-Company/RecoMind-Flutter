import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/diver_wid.dart';


class CompanyDiver extends StatelessWidget {
  const CompanyDiver({super.key,required this.width,required this.text});
  final double width ;
  final String text;
  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DiverWid(width: width),
        Gap(10),
        customText(text: text , color: Colors.white70 ,textsize: 12,),
        Gap(10),
        DiverWid(width: width)
      ],
    );
  }
}
