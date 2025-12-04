import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class Star extends StatelessWidget {
  final String text ;
  const Star({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25 , top: 80),
      child: Container(
        child: Row(children: [
          Image(image: AssetImage("assets/star.png"))
          ,customText(text:text!,color: Color(0xffEEEEEE),textsize: 16),
        ],),
      ),
    );
  }
}
