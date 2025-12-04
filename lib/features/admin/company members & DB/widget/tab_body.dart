import 'package:flutter/material.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/view/departments_view.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/view/management_view.dart';

class TabBody extends StatelessWidget {
  const TabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: TabBarView(
        children: [
          // الصفحة الأولى (Management)
          Center(child:  ManagementView()),
          // الصفحة الثانية (Departments)
          Center(child: DepartmentsView()),
        ],
      ),
    );
  }
}
