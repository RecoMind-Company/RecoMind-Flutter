import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart'; // مسار الـ ApiError الخاص بمشروعك[cite: 1]
import 'package:recomind/features/team%20leader/report%20history/data/report_model.dart';
import 'package:recomind/features/team%20leader/report%20history/data/report_reporistory.dart'; // مسار الريبو المحدث[cite: 3]
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
  SalesReportResponse? latestReport; // متغير لحفظ أحدث تقرير فقط

  Future<void> fetchLatestReport() async {
    try {
      setState(() {
        isLoading = true;
      });

      // 1. جلب بيانات المستخدم لمعرفة الـ teamId
      final task = await requestReport.user();
      teamid = task.teamId;

      // 2. جلب جميع التقارير الخاصة بهذا الفريق
      final List<SalesReportResponse> response = await requestReport.getSalesReports(teamid);

      setState(() {
        if (response.isNotEmpty) {
          // ترتيب التقارير تنازلياً من الأحدث للأقدم بناءً على الـ generatedDate
          response.sort((a, b) {
            if (a.generatedDate == null) return 1;
            if (b.generatedDate == null) return -1;
            return b.generatedDate!.compareTo(a.generatedDate!);
          });

          // أول عنصر في القائمة بعد الترتيب هو الأحدث دائماً
          latestReport = response.first;
        }
        isLoading = false;
      });
    } on ApiError catch (e) { // معالجة أخطاء الـ API المتوقعة[cite: 1, 2]
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
    fetchLatestReport(); // استدعاء البيانات عند فتح الصفحة مباشرة
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
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

            // التحكم في عرض الكارت بناءً على حالة الـ Request والتحميل
            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: SwappedShrinkingLoading(strokeWidth: 5,size: 50,),
                ),
              )
            else if (latestReport == null)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
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
                      builder: (context) => FullScreen(teamId: latestReport!.teamId,taskId: latestReport!.id,fixedText:latestReport!.content,reportid: latestReport!.id,)
                    ),
                  );
                  print("teamId: ${latestReport!.teamId},taskId: ${latestReport!.id},reportid: ${latestReport!.id}");
                },
              ),

            const Gap(160),
            GenerateReportButton(
              ontapExpand: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GenerateReportView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}