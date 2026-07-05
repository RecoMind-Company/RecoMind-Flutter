import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/team leader/report history/data/report_reporistory.dart';
import 'package:recomind/features/team%20leader/plan/view/plan.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({super.key, this.taskId, this.teamId, this.fixedText,this.reportid});
  final String? taskId;
  final String? teamId;
  final String? fixedText;
  final String? reportid;


  @override
  State<FullScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<FullScreen> {
  String? fixedText;
  bool isLoading = false;
  reportRepo resultrepo = reportRepo();

  final ScrollController _scrollController = ScrollController();
  double _readingProgress = 0.0;

  Future<void> getResult() async {
    try {
      setState(() => isLoading = true);

      final result = await resultrepo.getReportResult(
          widget.teamId, widget.taskId
      );

      fixedText = result.aiResponse?.replaceAll(RegExp(r'\\\\n'), r'\n');

      setState(() => isLoading = false);
    } on ApiError catch (e) {
      setState(() => isLoading = false);
      print("Error: ${e.message}");
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // getResult();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll > 0) {
        setState(() {
          _readingProgress = (currentScroll / maxScroll).clamp(0.0, 1.0);
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: SafeArea(
          child: Column(
            children: [
              // ==================== الجزء الثابت في الأعلى (Fixed Header) ====================
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10, bottom: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
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
                    const Gap(15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _readingProgress,
                          backgroundColor: const Color(0xFF1E2538),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF67D8F8)),
                          minHeight: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(15),

              // ==================== الجزء القابل للتمرير (Scrollable Content) ====================
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isLoading
                          ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Gap(40),
                            customText(
                              text: "Report is loading please wait ...",
                              color: AppColor.primaryColor,
                              fontweight: FontWeight.bold,
                              textsize: 20,
                            ),
                            const Gap(20),
                            CupertinoActivityIndicator(
                              color: AppColor.primaryColor,
                              radius: 20,
                            )
                          ],
                        ),
                      )
                          : Markdown(
                        data: widget.fixedText ?? "",
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        styleSheet: MarkdownStyleSheet(
                          h1: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                          h2: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                          h3: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          h4: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          h5: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          h6: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                          p: const TextStyle(color: Colors.white, fontSize: 16),
                          listBullet: const TextStyle(color: Colors.white, fontSize: 16),
                          blockSpacing: 10.0,
                          listIndent: 24.0,
                        ),
                      ),

                      // مسافة أمان مريحة بين النص والزر
                      const Gap(40),

                      // ==================== الزر المتوهج في آخر الكلام ====================
                      if (!isLoading)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 20),
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF67D8F8).withOpacity(0.45),
                                  blurRadius: 25,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 4),
                                ),
                                BoxShadow(
                                  color: const Color(0xFF67D8F8).withOpacity(0.2),
                                  blurRadius: 40,
                                  spreadRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF76E4FF),
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                print(widget.reportid!);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlanReviewScreen(reportId: widget.reportid!,),
                                  ),
                                );
                              },
                              child: const Text(
                                'Review & Execute Plan',
                                style: TextStyle(
                                  color: Color(0xFF090E1D),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}