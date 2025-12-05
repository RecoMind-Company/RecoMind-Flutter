import 'package:flutter/material.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class RecommendedMessageWidget extends StatelessWidget {
  const RecommendedMessageWidget({super.key,required this.text});
final String? text;
  @override
  Widget build(BuildContext context) {
    return  IntrinsicWidth(
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
          decoration:BoxDecoration(
              color:AppColor.darkBlue,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColor.primaryColor,width: 2)
          ),
          child: customText(text: text!,color: Colors.white,textsize: 12,fontweight: FontWeight.w500,)
      ),
    );
  }
}
