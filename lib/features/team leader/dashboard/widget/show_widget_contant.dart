import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/team%20leader/dashboard/data/porposal_model.dart';

void showValidationOverviewDialog(BuildContext context, {required ReportContent? content}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ValidationOverviewContent(content: content),
    ),
  );
}

class ValidationOverviewContent extends StatelessWidget {
  final ReportContent? content;

  const ValidationOverviewContent({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تجهيز النص بشكل ديناميكي بناءً على البيانات القادمة من الصفحة السابقة
    final String overviewText = content?.summary ??
        "This validation report evaluates the selected action plan before execution to ensure it is feasible, relevant, and aligned with business reality.";

    final String decisionText = content?.decision ?? "N/A";
    final String scoreText = content?.score != null ? "${content!.score}" : "0";

    final String history = content?.coreFindings?.historyAnalysis ?? "N/A";
    final String assets = content?.coreFindings?.assetsAssessment ?? "N/A";
    final String trends = content?.coreFindings?.industryTrends ?? "N/A";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF060B1B), // نفس لون الخلفية الداكن العميق بالصورة
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // زر الإغلاق (X) بالأعلى ناحية اليمين متطابق مع الصورة
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),

          const Text(
            "Overview",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(16),

          // منطقة النص القابلة للتمرير (Scrollable Area) لتستوعب النص بالكامل بأمان دون Overflow
          Flexible(
            child: Scrollbar(
              thumbVisibility: true, // لإظهار شريط التمرير الجانبي كما بالصورة
              thickness: 4,
              radius: const Radius.circular(2),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(right: 12), // مسافة بسيطة عن الـ Scrollbar
                child: Text(
                  "$overviewText\n\n"
                      "The validation process is designed to reduce execution risk and increase the likelihood of measurable impact by analyzing the plan across critical dimensions:\n\n"
                      "1. Industry & Peer Benchmarking\n"
                      "• $history\n\n"
                      "2. Internal Company Resources\n"
                      "• $assets\n\n"
                      "3. Market Trends & External Signals\n"
                      "• $trends\n\n"
                      "Only validated plans proceed to AI task generation and execution.\n\n"
                      "1. Validation Scope\n"
                      "The validation focuses on answering the following key questions:\n"
                      "• Has a similar plan been successfully implemented before?\n"
                      "• Final Decision: $decisionText\n"
                      "• Confidence Score: $scoreText",
                  style: const TextStyle(
                    color: Color(0xFFE2E8F0), // نفس لون الخط الفاتح بالصورة
                    fontSize: 14,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}