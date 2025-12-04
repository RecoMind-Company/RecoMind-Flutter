import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class EditButton extends StatelessWidget {
  const EditButton({super.key,required this.ontap});
final Function() ontap ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColor.primaryColor,
        ),
        child: Row(
          children: [
            Icon(Icons.edit,color: Color(0xFF060B1B),),
            Gap(8),
            customText(text: "Edit",color: Color(0xFF060B1B),fontweight: FontWeight.w500,textsize: 16,)
          ],
        ),
      ),
    );
  }
}
