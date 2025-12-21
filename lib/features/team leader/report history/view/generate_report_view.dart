import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/team%20leader/report%20history/data/report_reporistory.dart';
import 'package:recomind/features/team%20leader/report%20history/view/Expand.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/diver_wid.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';

import '../data/report_reporistory.dart';

class GenerateReportView extends StatefulWidget {
  const GenerateReportView({super.key});

  @override
  State<GenerateReportView> createState() => _GenerateReportViewState();
}

class _GenerateReportViewState extends State<GenerateReportView> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false ;
  reportRepo requestReport = reportRepo();
  Future<void> requestAnalysisTask() async {
    try {
      setState(() {
        isLoading = true ;
      });
      final task = await requestReport.getSetup(
        controller.text.trim()
      );

      print("TASK ID = ${task.taskId}");
      print("Status = ${task.status}");


      if (task.status == "PENDING") {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ExpandScreen(taskId: task.taskId,),));
      }
      setState(() {
        isLoading = false ;
      });

    } on ApiError catch (e) {
      setState(() {
        isLoading = false ;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
      print(e);
    }
  }
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
              textfield(hint: "Type here... (e.g. Sales growth ,...)",controller: controller,),
              Gap(12),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Icon(Icons.error_outline,color: Colors.white,size: 20,),
                Gap(5),
                customText(text: "You can include time period or KPIs if\nneeded.",color: Colors.white,textsize: 14,fontweight: FontWeight.w400,)
              ],),

              Gap(32),
              ///button
              isLoading==true ? CupertinoActivityIndicator(color: AppColor.primaryColor,radius: 20,):button(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ExpandScreen(),));
                // requestAnalysisTask();
                controller.clear();
              }, color: AppColor.primaryColor, borderColor: AppColor.primaryColor, buttonText: "Generate", textColor: Colors.black)
            ],
          ),
        ),
      )),
    );
  }
}
