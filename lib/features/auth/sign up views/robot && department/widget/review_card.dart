import 'package:flutter/material.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key,required this.Name});
final String? Name ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF060B1B),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.primaryColor),
      ),
      child: Row(children: [
        customText(text: Name!,textsize: 20,fontweight: FontWeight.w400,color: Colors.white,),
        Spacer(),
        Container(width:116,child: button(onPressed: (){}, color: AppColor.primaryColor, borderColor:  AppColor.primaryColor, buttonText: "Review", textColor: Colors.black))
      ],),
    );
  }
}
