import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/add%20team%20leader/view/markting_department.dart';
import 'package:recomind/features/admin/add%20team%20leader/view/no_team_leader.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/view/add_department.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/widget/card_Department.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class DepartmentsView extends StatelessWidget {
  const DepartmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(32),
        CardDepartment(
          ontap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>MarktingDepartment() ,));
          },
          Name: "Marketing",
          number: "10",
        ),
        Gap(25),
        CardDepartment(
          ontap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NoTeamLeader(),));
          },
          Name: "Sales",
          number: "0",
        ),
        Gap(25),
        CardDepartment(
          ontap: () {},
          Name: "HR",
          number: "0",
        ),
        Spacer(flex: 4,),
        GestureDetector(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddDepartment(),));
        }, child: Container(
          height: 44,
          width: 212,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Icon(CupertinoIcons.plus,color: Colors.black,),
          Gap(8),
          customText(text: "Add Department", fontweight: FontWeight.w400, textsize: 14, color: Colors.black,),
        ],),)),
        Spacer(flex: 1,)
      ],
    );
  }
}
