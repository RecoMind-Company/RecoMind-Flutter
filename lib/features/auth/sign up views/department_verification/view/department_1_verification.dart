import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/view/dapartment_2_verification.dart';
import 'package:recomind/features/auth/sign%20up%20views/plan%20&%20complete/view/plan.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/department_final_verification.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/widget/done_card.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/widget/review_card.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/data/team_Model.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/data/team_Repo.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class Department1Verification extends StatefulWidget {
  const Department1Verification({super.key});

  @override
  State<Department1Verification> createState() => _Department1VerificationState();
}

class _Department1VerificationState extends State<Department1Verification> {
  List<TeamNameModel> departments = [];
  final TeamRepo _teamRepo = TeamRepo();
  bool isLoading = true;

  // قائمة لتخزين أسماء الأقسام التي تم مراجعتها بالفعل لتحديث العداد وتبديل الكروت
  final Set<String> verifiedDepartmentNames = <String>{};

  @override
  void initState() {
    super.initState();
    _loadDepartments();
  }

  Future<void> _loadDepartments() async {
    try {
      final result = await _teamRepo.getTeamNames();
      setState(() {
        departments = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint("Error loading departments: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // حساب الأرقام ديناميكياً بناءً على الأقسام المخلصة
    final int reviewedCount = verifiedDepartmentNames.length;
    final int totalCount = departments.length;

    // الشرط: الزرار يفتح فقط لو خلصنا مراجعة كل الأقسام المتاحة بالكامل
    final bool isAllVerified = totalCount > 0 && reviewedCount == totalCount;

    return Scaffold(
      body: Containerwid(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    const Gap(70),
                    customText(text: "Departments Verification", textsize: 26, fontweight: FontWeight.w400, color: Colors.white),
                    const Gap(32),
                    Row(
                      children: [
                        customText(text: "Verify the data of each department before\nmoving forward", fontweight: FontWeight.w400, textsize: 16, color: Colors.white),
                      ],
                    ),
                    const Gap(20),

                    isLoading
                        ? const Center(child: SwappedShrinkingLoading(size: 40, strokeWidth: 2))
                        : Column(
                      children: List.generate(
                        departments.length,
                            (index) {
                          final String deptName = departments[index].name ?? "Unknown";
                          final bool isVerified = verifiedDepartmentNames.contains(deptName);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            // Toggling between DoneCard and ReviewCard
                            child: isVerified
                                ? DoneCard(
                              Name: deptName,
                            )
                                : ReviewCard(
                              Name: deptName,
                              ontap: () => _navigateToReview(deptName, index + 1),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(162)
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 162,
        decoration: BoxDecoration(
          color: const Color(0xFF060B1B),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(
          children: [
            const Gap(15),

            customText(
              text: "$reviewedCount : $totalCount",
              color: AppColor.primaryColor,
              textsize: 24,
              fontweight: FontWeight.w400,
            ),

            const Gap(16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 56),
              child: button(
                onPressed: isAllVerified
                    ? () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Plan()));
                }
                    : null,
                // ✨ تم تعديل اللون هنا ليكون بالدرجة المقترحة #979797 لما يكون الـ Button مقفول
                color: isAllVerified
                    ? AppColor.primaryColor
                    : const Color(0xFF979797),
                borderColor: isAllVerified
                    ? AppColor.primaryColor
                    : const Color(0xFF979797),
                buttonText: "Finalize Setup",
                // خليت التكست باللون الأسود أو الأبيض الهادي عشان يليق مع الخلفية الرمادية الجديدة
                textColor: isAllVerified ? Colors.black : Colors.white70,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToReview(String deptName, int currentIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dapartment2Verification(
          departmentName: deptName,
          currentDepartmentIndex: verifiedDepartmentNames.length + 1,
          totalDepartmentsCount: departments.length,
          onVerificationComplete: () {
            setState(() {
              verifiedDepartmentNames.add(deptName);
            });
          },
        ),
      ),
    );
  }
}