import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class DepartmentCard extends StatelessWidget {
   DepartmentCard({super.key,required this.name,required this.onTap});
  String name;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColor.primaryColor,width: 2)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          customText(
            text:name,
            color: Colors.white,
            textsize: 15,
            fontweight: FontWeight.w400,
          ),
          GestureDetector(
            onTap: onTap,
            child: const Icon(
              CupertinoIcons.xmark_circle,
              color: Colors.red,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
