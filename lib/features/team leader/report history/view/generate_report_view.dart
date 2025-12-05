import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/team%20leader/report%20history/view/Expand.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/diver_wid.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';

class GenerateReportView extends StatelessWidget {
  const GenerateReportView({super.key});

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
              Gap(32),
              textfield(hint: "Type here... (e.g. Sales growth ,...)"),
              Gap(12),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Icon(Icons.error_outline,color: Colors.white,size: 20,),
                Gap(5),
                customText(text: "You can include time period or KPIs if\nneeded.",color: Colors.white,textsize: 14,fontweight: FontWeight.w400,)
              ],),

              Gap(32),
              ///button
              button(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ExpandScreen(),));
              }, color: AppColor.primaryColor, borderColor: AppColor.primaryColor, buttonText: "Generate", textColor: Colors.black)
            ],
          ),
        ),
      )),
    );
  }
}
