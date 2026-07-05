import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/team%20leader/report%20history/data/report_reporistory.dart';
import 'package:recomind/features/team%20leader/report%20history/view/full_screen.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/texttest.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/diver_wid.dart';

class ExpandScreen extends StatefulWidget {
  const ExpandScreen({super.key, this.taskId,this.teamId});

  final String? taskId;
  final String? teamId;

  @override
  State<ExpandScreen> createState() => _ExpandScreenState();
}

class _ExpandScreenState extends State<ExpandScreen> {
  /// get report
  String? fixedText;
  bool isLoading = false;
  reportRepo resultrepo = reportRepo();
  late String reportID;

  Future<void> getResult() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await resultrepo.getReportResult(widget.taskId,widget.teamId,);
      print("TASK ID = ${result.aiResponse}");
      print("Status = ${result.generatedDate}");
      fixedText = result.aiResponse?.replaceAll(RegExp(r'\\\\n'), r'\n');
      reportID = result.id!;


      print("Fixed Result:\n$fixedText");
      setState(() {
        isLoading = false;
      });
    } on ApiError catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: ${e.message}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResult();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColor.darkBlue,
      backgroundColor: AppColor.primaryColor,
      onRefresh: () async {
        await getResult();
      },
      child: Scaffold(
        body: Containerwid(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Expanded(
              child: Column(
                children: [
                  Gap(90),
                  Row(
                    children: [
                      Gap(5),
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
                        text: "Your insights and action plan are ready",
                        textsize: 19,
                        fontweight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Gap(40),

                  isLoading == true
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(
                        text: "Report is loading please wait ...",
                        color: AppColor.primaryColor,
                        fontweight: FontWeight.bold,
                        textsize: 20,
                      ),
                      Gap(40),
                      Center(
                          child: SwappedShrinkingLoading(strokeWidth: 5,size: 50,))
                    ],
                  ): Stack(
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 20,
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                              height: 500,
                              padding:
                                  EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:AppColor.darkBlue,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: AppColor.primaryColor,width: 3)
                              ),
                              child: isLoading == true
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        customText(
                                          text: "Report is loading please wait ...",
                                          color: AppColor.primaryColor,
                                          fontweight: FontWeight.bold,
                                          textsize: 20,
                                        ),
                                        Gap(20),
                                        Center(
                                            child: CupertinoActivityIndicator(
                                          color: AppColor.primaryColor,
                                          radius: 20,
                                        ))
                                      ],
                                    )
                                  : Markdown(
                                    data: fixedText.toString(),
                                    physics: NeverScrollableScrollPhysics(),
                                    styleSheet: MarkdownStyleSheet(
                                      h1: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                      h2: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      h3: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      h4: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      h5: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      h6: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      p: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      listBullet: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      blockSpacing: 10.0,
                                      listIndent: 24.0,
                                    ),
                                  )),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Container(
                              height: 500,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColor.darkBlue.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          right: 30,
                          child: GestureDetector(
                            onTap: () {
                              print(reportID);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreen(teamId: widget.teamId,taskId: widget.taskId,fixedText: fixedText.toString(),reportid:reportID,),));
                            },
                            child: Container(
                              height: 40,
                              width: 60,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SvgPicture.asset("assets/Team leader svg/zoom.svg"),
                            ),
                          ),
                        ) ,
                      ],
                    ),

                  ///Divider
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
