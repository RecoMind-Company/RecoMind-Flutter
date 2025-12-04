import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/log%20in%20views/verify_login%20&%20welcome/view/verify_login.dart';
import 'package:recomind/features/auth/log%20in%20views/verify_login%20&%20welcome/widget/input_email.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class EnterEmail extends StatelessWidget {
  const EnterEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Containerwid(
      child: SafeArea(
          child: Column(children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new,
                      color: Color(0xffeeeeee), size: 28)),
              Spacer(
                flex: 2,
              ),
              customText(
                  text: "Reset Password",
                  textsize: 30,
                  color: Color(0xffeeeeeee)),
              Spacer(
                flex: 6,
              ),
            ],
          ),
        ),
        Gap(51),
        Image(image: AssetImage("assets/Login/reset.png")),
        Gap(48),
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: customText(
              text: "Enter your Email address to Reset\nYour Password",
              textsize: 20,
              color: Color(0xffeeeeeee)),
        ),
        Gap(32),

        ///input email
        InputEmail(),
        Gap(32),

        ///reset button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: button(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VerifyLogin(),));
              },
              color: AppColor.primaryColor,
              borderColor: AppColor.primaryColor,
              buttonText: "Reset Password",
              textColor: Colors.black),
        ),
      ])),
    ));
  }
}
