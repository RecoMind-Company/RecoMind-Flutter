import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class Bar extends StatelessWidget {
  final int reviewedCount; // عدد الأقسام المراجعة حالياً
  final int totalCount;    // العدد الكلي للأقسام

  const Bar({
    super.key,
    required this.reviewedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final double progressPercent = totalCount > 0
        ? (reviewedCount / totalCount).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      children: [
        const Gap(8),
        customText(
          text: "Tables reviewed",
          textsize: 18,
          fontweight: FontWeight.w400,
          color: const Color(0xFFB5B5B5),
        ),
        const Gap(4),
        LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth = constraints.maxWidth;

            // حساب عرض الجزء الأزرق القادم من اليمين للشمال
            final double currentProgressWidth = maxWidth * progressPercent;

            return Container(
              height: 31,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFC6C6C6), // الخلفية الرمادية الثابتة
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              // ✨ تم إضافة الـ ClipRRect هنا لقص الحواف الزائدة للبار الأزرق عند اكتماله تماماً
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Stack(
                  children: [
                    // 1️⃣ النص الافتراضي باللون الأسود (يظهر في الجزء الرمادي)
                    Center(
                      child: customText(
                        text: "$reviewedCount : $totalCount",
                        color: const Color(0xFF060B1B),
                        fontweight: FontWeight.bold,
                        textsize: 18,
                      ),
                    ),

                    // 2️⃣ الـ Progress اللامع المتمدد من اليمين
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      width: currentProgressWidth,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF020B28),
                              Color(0xFF51D9FF),
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        // كشف النص الأبيض بالتوازي مع حركة البار
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              width: maxWidth,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: customText(
                                  text: "$reviewedCount : $totalCount",
                                  color: Colors.white,
                                  fontweight: FontWeight.bold,
                                  textsize: 18,
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
            );
          },
        ),
      ],
    );
  }
}