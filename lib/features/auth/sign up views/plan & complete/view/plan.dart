import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/auth/sign%20up%20views/plan%20&%20complete/widget/button_plan.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../widget/star.dart';





class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
          child: Column(

            children: [
              Gap(80),
              Container(width: 345,child: customText(text: "Choose Your Plan" ,textsize: 28 , color: Color(0xffEEEEEE ))),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(width: double.infinity,
                  height: 500,
                  child: Stack(children: [
                    Image(image: AssetImage("assets/plan.png")),
                    Padding(
                      padding: const EdgeInsets.only(left: 25 , top: 25),
                      child: customText(text: "500 LE / Month",color: Color(0xffEEEEEE),textsize: 20,fontweight: FontWeight.bold),),
                    Star(text:" AI-Generatd Plans"),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Star(text: " Unlimited Reports"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Star(text: " Real-Time KPI Dashboard "),
                    ),

                   ButtonPlan()
                  ],),
                ),
              )

            ],

          )
      ),
    );

  }
}
