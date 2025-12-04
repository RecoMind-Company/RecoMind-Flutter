import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class EditButton extends StatelessWidget {
  const EditButton({super.key,required this.ontap});
final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: ontap,
        child: Container(
          height: 44,
          width: 133,
          decoration: BoxDecoration(
              color: Color(0xFF060B1B),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: AppColor.primaryColor, width: 1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ),
              Gap(8),
              customText(
                text: "Edit Profile",
                fontweight: FontWeight.w400,
                textsize: 14,
                color: AppColor.primaryColor,
              ),
            ],
          ),
        ));
  }
}
