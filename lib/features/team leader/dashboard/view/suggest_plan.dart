import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/team%20leader/dashboard/data/porposal_model.dart';
import 'package:recomind/features/team%20leader/dashboard/data/porposal_repo.dart';
import 'package:recomind/features/team%20leader/dashboard/widget/show_widget_contant.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';


class SuggestedPlanScreen extends StatefulWidget {
  const SuggestedPlanScreen({super.key, required this.id});
  final String? id;

  @override
  State<SuggestedPlanScreen> createState() => _SuggestedPlanScreenState();
}

class _SuggestedPlanScreenState extends State<SuggestedPlanScreen> {
  final ProposalRepository _reportRepository = ProposalRepository();
  final ProposalRepository _updateStatusRepository = ProposalRepository(); // 💡 تعريف الـ repo

  late Future<dynamic> _reportFuture;
  bool _isActionLoading = false; // 💡 متغير لمتابعة حالة التحميل أثناء الضغط على الأزرار

  @override
  void initState() {
    super.initState();
    _reportFuture = _reportRepository.fetchReportDetails(widget.id ?? "");
  }

  /// 💡 دالة مركزية لتحديث حالة التقرير وتجنب تكرار الكود
  Future<void> _handleUpdateStatus(int statusValue, String statusText) async {
    if (widget.id == null) return;

    setState(() {
      _isActionLoading = true;
    });

    final request = UpdateReportStatusRequestModel(
      id: widget.id!,
      status: statusValue,
    );

    final response = await _updateStatusRepository.updateReportStatus(request);

    setState(() {
      _isActionLoading = false;
    });

    if (response is! ApiError) {
      // إشعار بالنجاح
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Plan $statusText Successfully!"),
          backgroundColor: statusValue == 3 ? Colors.green : Colors.redAccent,
        ),
      );
      // 💡 قفل الشاشة فوراً للـ Approve والـ Reject وتمرير true لعمل ريلود وحذف الكارد من الشاشة السابقة
      if (mounted) {
        Navigator.pop(context, true);
      }
    } else {
      // إشعار في حالة حدوث خطأ من السيرفر
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message ?? "Failed to update status. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBlue,
      body: SafeArea(
        top: false,
        child: FutureBuilder<dynamic>(
          future: _reportFuture,
          builder: (context, snapshot) {
            // 1. حالة التحميل (Loading)
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SwappedShrinkingLoading(size: 40, strokeWidth: 4),
              );
            }

            // 2. حالة حدوث خطأ أو بيانات غير صالحة
            if (snapshot.hasError || snapshot.data is! ValidationReportModel) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Failed to load validation report details.",
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      ),
                      const Gap(16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _reportFuture = _reportRepository.fetchReportDetails(widget.id ?? "");
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor),
                        child: const Text("Retry", style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              );
            }

            // استخراج كائن البيانات الفعلي المرجوع
            final ValidationReportModel report = snapshot.data as ValidationReportModel;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  CupertinoIcons.back,
                                  color: Colors.white,
                                  size: 35,
                                )),
                            customText(
                              text: "Suggested Plan",
                              color: Colors.white,
                              fontweight: FontWeight.w400,
                              textsize: 24,
                            ),
                            SvgPicture.asset("assets/Team leader svg/chat.svg")
                          ],
                        ),
                        const Gap(40),
                        Text(
                          (report.queryText != null && report.queryText!.isNotEmpty)
                              ? report.queryText!
                              : "Social Media Growth",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const Gap(10),
                        const Text("Suggested By",
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Row(children: [
                          const CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xFF151B29),
                            child: Icon(
                              Icons.person,
                              color: Colors.white54,
                              size: 16,
                            ),
                          ),
                          const Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                report.author ?? "Magdy Mohammed",
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                              const Text("Developer",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ]),
                        const Gap(20),
                        const Text("Description", style: TextStyle(color: Colors.grey)),
                        const Gap(5),
                        Text(
                          report.reportContent?.summary ??
                              "We plan to open a branch in Nasr City within 3 months with a budget of 500K EGP...",
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Gap(20),
                        const Text("Validation Report",
                            style: TextStyle(color: Colors.grey)),
                        const Gap(10),
                        // كارت الـ Overview
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xff060B1B),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.white10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white54.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(30),
                                  const Text(
                                    "Overview",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Gap(12),
                                  Text(
                                    "Decision: ${report.reportContent?.decision ?? 'N/A'} (Confidence Score: ${report.reportContent?.score ?? 0})\n\n"
                                        "This validation report evaluates the selected action plan before execution to ensure it is feasible, relevant, and aligned with business reality. The validation process is designed to reduce execution risk and increase the likelihood of measurable impact:\n\n"
                                        "• History Analysis: ${report.reportContent?.coreFindings?.historyAnalysis ?? 'Analyzing past trends...'}\n"
                                        "• Assets Assessment: ${report.reportContent?.coreFindings?.assetsAssessment ?? 'Evaluating internal resources...'}",
                                    style: const TextStyle(
                                        color: Color(0xFFEFEFEF),
                                        fontSize: 16,
                                        height: 1.5,
                                        fontWeight: FontWeight.w400),
                                    maxLines: 10,
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    showValidationOverviewDialog(context, content: report.reportContent);
                                  },
                                  child: Container(
                                      width: 44,
                                      height: 36,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff7ADDF0),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: SvgPicture.asset(
                                          "assets/Team leader svg/zoom.svg")),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Gap(40),
                        // عرض مؤشر تحميل عام فوق الأزرار عند الضغط للحماية والتأكيد البصري
                        if (_isActionLoading)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 16.0),
                            child: CupertinoActivityIndicator(color: Colors.white),
                          ),
                        Row(children: [
                          Expanded(
                              flex: 1,
                              child: button(
                                  onPressed: _isActionLoading
                                      ? () {}
                                      : (){
                                    _handleUpdateStatus(2, "Rejected");
                                    print(widget.id);
                                  }, // استدعاء حالة الـ Reject
                                  color: const Color(0xFF212636),
                                  borderColor: const Color(0xFF212636),
                                  buttonText: "Reject",
                                  textColor: _isActionLoading ? Colors.grey : Colors.redAccent)),
                          const Gap(15),
                          Expanded(
                              flex: 2,
                              child: button(
                                  onPressed: _isActionLoading
                                      ? () {}
                                      : (){
                                    _handleUpdateStatus(3, "Approved");
                                    print(widget.id);
                                  } , // استدعاء حالة الـ Approve
                                  color: _isActionLoading ? const Color(0xFF212636) : AppColor.primaryColor,
                                  borderColor: _isActionLoading ? const Color(0xFF212636) : AppColor.primaryColor,
                                  buttonText: "Approve & Execute",
                                  textColor: _isActionLoading ? Colors.grey : Colors.black)),
                        ]),
                        const Gap(30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}