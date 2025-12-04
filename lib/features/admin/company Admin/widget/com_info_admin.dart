import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../shared/widgets/custom_text.dart';


class ComInfoAdmin extends StatelessWidget {
  const ComInfoAdmin({super.key , required this.title , required this.name});
  final String title , name ;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          customText(text: title,textsize: 12,fontweight: FontWeight.w400,color: Color(0xFFB5B5B5),),
        ],
      ),
      Gap(4),
      Row(
        children: [
          customText(text: name,textsize: 14,fontweight: FontWeight.w400,color: Color(0xFFFFFFFF),),

        ],
      ),
      Gap(16)
    ],);
  }
}
