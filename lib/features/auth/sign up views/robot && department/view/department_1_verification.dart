import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/dapartment_2_verification.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/department_final_verification.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/widget/done_card.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/widget/review_card.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class Department1Verification extends StatefulWidget {
   Department1Verification({super.key});

  @override
  State<Department1Verification> createState() => _Department1VerificationState();
}

class _Department1VerificationState extends State<Department1Verification> {
final List department = [
  "Sales",
  "HR",
  "Operations",
  "Production",
  "Purchasing",
  "PR"
];
bool isclicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Gap(70),
                  customText(text: "Departments Verification",textsize: 26,fontweight: FontWeight.w400,color: Colors.white,),
                  Gap(32),
                  Row(
                    children: [
                      customText(text: "Verify the data of each department before\nmoving forward",fontweight: FontWeight.w400,textsize: 16,color: Colors.white,),
                    ],
                  ),
                  Gap(20),
                 Column(children: List.generate(department.length, (index) => Padding(
                   padding: const EdgeInsets.only(bottom: 32.0),
                   child: ReviewCard(Name: department[index],ontap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dapartment2Verification(),));
                   },),
                 ),)),

                ],
              ),
            ),
            Gap(162)
          ],
        ),
      ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 162,
        decoration: BoxDecoration(
            color: Color(0xFF060B1B),
            boxShadow: [ BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 1,
            )]
        ),
        child: Column(children: [
          Gap(15),
          customText(text: "0 : 10",color: AppColor.primaryColor,textsize: 24,fontweight: FontWeight.w400,),
          Gap(16),
          Container(padding:EdgeInsets.symmetric(horizontal: 56),child: button(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DepartmentFinalVerification(),));}, color:isclicked==false ?CupertinoColors.inactiveGray:AppColor.primaryColor, borderColor: AppColor.primaryColor, buttonText: "Finalize Setup", textColor: Colors.black))
        ],),
      ),
    );
  }
}
