import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class ActionContainer extends StatelessWidget {
   ActionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     height: 89,
      width: 221,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFF3F404D),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline,color: Colors.red,),
              Gap(5),
              customText(text:"Action Required",color: Color(0xFFEEEEEE),fontweight: FontWeight.bold,textsize: 18,)
            ],
          ),
         Gap(8),
         Row(children: [
           SizedBox(
               height:20,child: VerticalDivider(color: Colors.red,thickness: 2)),
           Gap(5),
           customText(text: "3 Plans",color: Color(0xFFF2F2F2),fontweight: FontWeight.w400,textsize: 14,)
         ],)
      ]
      )
    );
  }
}
