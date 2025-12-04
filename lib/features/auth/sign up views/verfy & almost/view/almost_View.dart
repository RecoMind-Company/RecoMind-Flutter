import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/verfy%20&%20almost/widget/almost_Button.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class AlmostView extends StatefulWidget {
  const AlmostView({super.key});

  @override
  State<AlmostView> createState() => _AlmostViewState();
}

class _AlmostViewState extends State<AlmostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Column(
            children: [
              customText(
                text: "You're almost there !",
                color: Color(0xFFEEEEEE), textsize: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Image(image: AssetImage("assets/almost.png")),
              ),
              Gap(50),
              customText(
                text: "Let's build your workspace\ntogether",
               color: Colors.white70, textsize: 25,
              ),
              Gap(50),
             AlmostButton()
            ],
          ),
        ),
      ),
    );
  }
}
