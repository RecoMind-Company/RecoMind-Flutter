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
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class ExpandScreen extends StatefulWidget {
  const ExpandScreen({super.key, this.taskId, this.teamId});

  final String? taskId;
  final String? teamId;

  @override
  State<ExpandScreen> createState() => _ExpandScreenState();
}

class _ExpandScreenState extends State<ExpandScreen> {
  String? fixedText;
  bool isLoading = false;
  final reportRepo resultrepo = reportRepo();
  late String reportID;

  Future<void> getResult() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await resultrepo.getReportResult(widget.taskId, widget.teamId);
      fixedText = result.aiResponse?.replaceAll(RegExp(r'\\\\n'), r'\n');
      reportID = result.id ?? '';
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
    super.initState();
    getResult();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColor.darkBlue,
      backgroundColor: AppColor.primaryColor,
      onRefresh: getResult,
      child: Scaffold(
        body: Containerwid(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const Gap(90),
                  Row(
                    children: [
                      const Gap(5),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const Gap(40),

                  /// Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(
                        text: "Insights and action plan are ready",
                        textsize: 19,
                        fontweight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const Gap(40),

                  /// Content Area
                  isLoading
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(
                        text: "Report is loading please wait ...",
                        color: AppColor.primaryColor,
                        fontweight: FontWeight.bold,
                        textsize: 18,
                      ),
                      const Gap(40),
                      const Center(
                        child: SwappedShrinkingLoading(strokeWidth: 5, size: 50),
                      )
                    ],
                  )
                      : Stack(
                    children: [
                      Material(
                        color: Colors.transparent,
                        elevation: 20,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 500,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.darkBlue,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColor.primaryColor, width: 3),
                          ),
                          child: Markdown(
                            data: fixedText ?? "No content available",
                            physics: const NeverScrollableScrollPhysics(),
                            styleSheet: MarkdownStyleSheet(
                              h1: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                              h2: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                              h3: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              p: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
                              listBullet: const TextStyle(color: Colors.white, fontSize: 15),
                              blockSpacing: 12.0,
                              listIndent: 20.0,
                            ),
                          ),
                        ),
                      ),

                      // طبقة الـ Blur مدمجة فوق الـ Card ومنسقة الأبعاد
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

                      // زرار الـ Zoom في مقدمة الـ Stack لضمان استجابة اللمس
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreen(
                                  teamId: widget.teamId,
                                  taskId: widget.taskId,
                                  fixedText: fixedText.toString(),
                                  reportid: reportID,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 44,
                            width: 64,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SvgPicture.asset("assets/Team leader svg/zoom.svg"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}