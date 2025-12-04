import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/diver_wid.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class DiverSignUp extends StatelessWidget {
  const DiverSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       DiverWid(width: 90,),
        customText(text: "Or You Can Sign Up With" , color: Colors.white70 ,),
       DiverWid(width: 90,)
      ],
    );
  }
}
