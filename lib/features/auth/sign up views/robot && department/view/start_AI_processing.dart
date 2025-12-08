import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/data/robot_repo.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/robot_root.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class StartAiProcessing extends StatefulWidget {
  const StartAiProcessing({super.key});

  @override
  State<StartAiProcessing> createState() => _StartAiProcessingState();
}

class _StartAiProcessingState extends State<StartAiProcessing> {
  bool isLoading = false;
  RobotRep robotRep = RobotRep();
    Future<void> robotRequest ()async{
      try{
        setState(() {
          isLoading = true;
        });
        final response = await robotRep.requestRobot();
        print(response);
        if(response != null){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RobotRoot(Id: response,),), (route) =>false ,);
        }
        setState(() {
          isLoading = false;
        });
      }on ApiError catch(e){
        setState(() {
          isLoading = false;
        });
        print(e.message);
      }
    }
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
          isLoading==true ? Center(child: CupertinoActivityIndicator(radius: 20,color: AppColor.primaryColor,),):button(onPressed: (){
            robotRequest ();
          }, color: AppColor.primaryColor, borderColor: AppColor.primaryColor, buttonText: "Start AI Processing", textColor: Colors.black)

        ],),
      )),
    );
  }
}
