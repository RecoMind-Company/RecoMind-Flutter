import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class TitleTextField extends StatelessWidget {
  const TitleTextField({super.key,required this.text});
 final String text;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          alignment: Alignment.topLeft,
          width: double.infinity,
          child: customText(text: text,
           textsize: 16,
            color: Color(0xFFB8ADAD),
            fontweight: FontWeight.w400,)),
      SizedBox(
        height: 8,
      ),
    ],);
  }
}
