import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/widget/loading_bar.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class Step3Widget extends StatelessWidget {
  const Step3Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(child:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(147),
            SvgPicture.asset("assets/Robot/robo_position_4.svg"),
            Gap(32),
            customText(text: "Reviewing your data to ensure everything is clear and ready...",
              color: Colors.white,
              fontweight: FontWeight.w400,
              textsize: 22,
              iscenter: true,),
            Gap(12),
            Gap(32),
            LoadingBar(width: 185,Number: "50 %",) ,
            Gap(4),
            customText(text: "This may take a few minutes",fontweight: FontWeight.w400,textsize: 10,color: Color(0xFFEFEFEF),)

          ],),)
      )
      ,
    );
  }
}
