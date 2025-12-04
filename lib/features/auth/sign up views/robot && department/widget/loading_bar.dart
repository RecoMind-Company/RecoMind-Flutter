import 'package:flutter/material.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class LoadingBar extends StatelessWidget {
  const LoadingBar({super.key,required this.Number,required this.width});
  final String? Number;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        alignment: Alignment.center,
        height: 33.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF292F3C),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      Positioned(
        right: 0,
        child: Container(
          height: 33,
          width: width,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      Padding(padding: EdgeInsetsGeometry.only(top: 4),
        child: Center(
          child: customText(text: Number!,
            textsize: 18,
            fontweight: FontWeight.bold,
            color: Colors.white,),
        ),
      ),
    ],);
  }
}
