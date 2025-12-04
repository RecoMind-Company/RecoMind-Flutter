import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/department_1_verification.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/robot_root.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class AiAllSet extends StatelessWidget {
  const AiAllSet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
          Gap(100),
          ///title
          customText(text: "All set! The AI has organized your data",textsize: 24,fontweight: FontWeight.w400,color: Colors.white,iscenter: true,),
          Gap(20),
          SvgPicture.asset("assets/Robot/robo_position_6.svg"),
          Gap(32),
          customText(text: "take a quick look to confirm\neverything’s in place",textsize: 20,fontweight: FontWeight.w400,color: Colors.white,iscenter: true,),
          Gap(32),
          button(onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Department1Verification(),), (route) =>false ,);
          }, color: AppColor.primaryColor, borderColor: AppColor.primaryColor, buttonText: "Review data", textColor: Colors.black)

        ],),
      )),
    );
  }
}
