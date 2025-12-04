import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class Department extends StatelessWidget {
  const Department({super.key, required this.depList});
final List depList;
  @override
  Widget build(BuildContext context) {
    return  Column(children: List.generate(depList.length, (index) =>
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xFF454A5599),
            ),
            child: customText(text: depList[index],textsize: 16,fontweight: FontWeight.w400,color: Color(0xFFFFFFFF),),
          ),
        ) ,));
  }
}
