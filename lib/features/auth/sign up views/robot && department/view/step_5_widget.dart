import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/widget/loading_bar.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class Step5Widget extends StatelessWidget {
  const Step5Widget({super.key});

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
            SvgPicture.asset("assets/Robot/robo_position_5.svg"),
            Gap(32),
            customText(text: "Assigning your data to the right departments…\nalmost there!",
              color: Colors.white,
              fontweight: FontWeight.w400,
              textsize: 22,
              iscenter: true,),
            Gap(32),
            LinearProgressIndicator(
              minHeight: 30,
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(25),
              backgroundColor: Color(0xFF454A5599),
            ) ,
            Gap(8),
            customText(text: "This may take a few minutes",fontweight: FontWeight.w400,textsize: 10,color: Color(0xFFEFEFEF),)

          ],),)
      )
      ,
    );
  }
}
