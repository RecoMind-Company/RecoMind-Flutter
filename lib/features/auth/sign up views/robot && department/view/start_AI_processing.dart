import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/robot_root.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class StartAiProcessing extends StatelessWidget {
  const StartAiProcessing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          Gap(70),
          ///title
          customText(text: "You're All Set!",textsize: 26,fontweight: FontWeight.w400,color: Colors.white,),
          Gap(8),
          ///subtitle
          customText(text: "Your company setup is ready.",color: Colors.white,fontweight: FontWeight.w400,textsize: 18,),
          Gap(32),
          SvgPicture.asset("assets/Robot/robo_position_1.svg"),
          Gap(16),
          customText(text: "Our AI system will now analyze your database, understand its structure, and smartly distribute your data across all departments.\nThis process will take just a few moments.",textsize: 14,fontweight: FontWeight.w400,color: Colors.white,),
          Gap(32),
          button(onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RobotRoot(),), (route) =>false ,);
          }, color: AppColor.primaryColor, borderColor: AppColor.primaryColor, buttonText: "Start AI Processing", textColor: Colors.black)

        ],),
      )),
    );
  }
}
