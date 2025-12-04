import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/widget/tabBar.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/widget/tab_body.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class CompanyMembers extends StatelessWidget {
  const CompanyMembers({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. نستخدم DefaultTabController لإدارة حالة التبويبات
    return DefaultTabController(
      length: 2, // عدد التبويبات (Management و Departments)
      child: Scaffold(
        backgroundColor: const Color(0xFF060B1B), // لون خلفية داكن

        body: Containerwid(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // محاذاة العناصر لليسار
            children: [
              Gap(70),
              // 2. العنوان وزر الرجوع (محاكاة الـ AppBar)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // زر الرجوع
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(CupertinoIcons.back, color: Colors.white, size: 30),
                    ),

                    const Gap(32), // مسافة بين الزر والعنوان

                    // العنوان
                    customText(
                      text: "Company Members",
                      color: const Color(0xFFFFFFFF),
                      fontweight: FontWeight.w500,
                      textsize: 24,
                    ),
                  ],
                ),
              ),

              const Gap(32),
              ///Tab bar
              Tabbar(),


              /// tab body
              TabBody(),

            ],
          ),
        ),
      ),
    );
  }
}