import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class GenerateReportButton extends StatelessWidget {
  const GenerateReportButton({super.key, required this.ontapExpand});
  final Function()? ontapExpand;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapExpand,
      child: Container(
        height: 55,
        width: 239,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color:AppColor.darkBlue,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color:AppColor.primaryColor,width: 2)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/Team leader svg/pen_writing.svg"),
            Gap(8),
            customText(
              text: "Generate My Report",
              fontweight: FontWeight.w400,
              textsize: 16,
              color: AppColor.primaryColor,
            ),


          ],
        ),
      ),
    );
  }
}
