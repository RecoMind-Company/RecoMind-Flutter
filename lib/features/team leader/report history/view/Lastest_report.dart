import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/team%20leader/report%20history/data/report_model.dart';
import 'package:recomind/features/team%20leader/report%20history/data/report_reporistory.dart';
import 'package:recomind/features/team%20leader/report%20history/view/full_screen.dart';
import 'package:recomind/features/team%20leader/report%20history/view/generate_report_view.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/drop_Down_History.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/history_card.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/lastest_card.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/search_widget.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../widget/generate_report_button.dart';
import 'Expand.dart';

class LastestReport extends StatefulWidget {
  const LastestReport({super.key});

  @override
  State<LastestReport> createState() => _LastestReportState();
}

class _LastestReportState extends State<LastestReport> {
  bool isLoading = false;
  final reportRepo requestReport = reportRepo();
  late String teamid;
  SalesReportResponse? latestReport;

  Future<void> fetchLatestReport() async {
    try {
      setState(() {
        isLoading = true;
      });

      final task = await requestReport.user();
      teamid = task.teamId;

      final List<SalesReportResponse> response = await requestReport.getSalesReports(teamid);

      setState(() {
        if (response.isNotEmpty) {
          response.sort((a, b) {
            if (a.generatedDate == null) return 1;
            if (b.generatedDate == null) return -1;
            return b.generatedDate!.compareTo(a.generatedDate!);
          });
          latestReport = response.first;
        }
        isLoading = false;
      });
    } on ApiError catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
      print(e);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Unexpected error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLatestReport();
  }

  @override
  Widget build(BuildContext context) {
    // استخدمنا LayoutBuilder لضمان ملء المساحة بالكامل للـ Stack الخارجي
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: Colors.transparent,
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Stack(
            children: [
              /// 1. محتوى الصفحة القابل للتمرير (بدون الزرار)
              Positioned.fill(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 100), // مساحة أمان تحت عشان الكروت متنزلش تحت الزرار الثابت
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          customText(
                            text: "Your Ongoing Insights",
                            fontweight: FontWeight.w500,
                            textsize: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const Gap(2),
                      Row(
                        children: [
                          customText(
                            text: "Delivered automatically, tailored to your goals",
                            fontweight: FontWeight.w500,
                            textsize: 14,
                            color: const Color(0xFFB5B5B5),
                          ),
                        ],
                      ),
                      const Gap(32),

                      if (isLoading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 60.0),
                            child: SwappedShrinkingLoading(strokeWidth: 5, size: 50),
                          ),
                        )
                      else if (latestReport == null)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 60.0),
                            child: Text(
                              "No reports found yet.",
                              style: TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                          ),
                        )
                      else
                        LastestCard(
                          ontapExpand: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreen(
                                  teamId: latestReport!.teamId,
                                  taskId: latestReport!.id,
                                  fixedText: latestReport!.content,
                                  reportid: latestReport!.id,
                                ),
                              ),
                            );
                            print("teamId: ${latestReport!.teamId},taskId: ${latestReport!.id},reportid: ${latestReport!.id}");
                          },
                        ),
                    ],
                  ),
                ),
              ),

              /// 2. الزرار الثابت تماماً في أسفل الشاشة (خارج نطاق الـ Scroll والـ Loading)
              Positioned(
                bottom: 30,
                left: 40, // خليتها 20 بدل 50 عشان تكون متناسقة ريسبونسيف مع أطراف التصميم، تقدر ترجعها 50 لو حابب
                right: 40,
                child: GenerateReportButton(
                  ontapExpand: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GenerateReportView(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}