import 'package:flutter/material.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/view/add_plan.dart';


class ValidateButton extends StatelessWidget {
  const ValidateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddPlan(),));
      },
      child: Container(
        width: 183,
        height: 32,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text("Validate Your Idea Now", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}
