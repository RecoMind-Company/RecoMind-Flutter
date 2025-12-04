import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/views/verify/widget/resend_Line.dart';
import 'package:recomind/shared/views/verify/widget/verify_number_input.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key ,required this.navigatScreen}) : super(key: key ,);
  final Widget navigatScreen ;
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool isFilled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60, right: 24, left: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    /// title
                    const customText(
                      text: "Verification Code",
                        color: Color(0xFFEEEEEE),
                        textsize: 30,
                        fontweight:FontWeight.w400,
                      ),
                    Gap(50),

                    ///image
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Image(image: AssetImage("assets/verify.png")),
                    ),
                    Gap(16),

                    ///gmail
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: const customText(
                        text: "A verification code has been sent to your\n Email via Gmail. Enter the code to proceed.",
                          color:Color(0xFFEEEEEE),
                          textsize:15,
                        ),
                    ),
                    Gap(30),

                    /// input number
                    VerifyNumberInput(
                      isFilled: isFilled,
                      pinController: _pinController,),
                    Gap(20),

                    /// resend
                    ResendLine(),
                    const SizedBox(height: 20),
                    button(
                        onPressed: () {

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => widget.navigatScreen),
                            );

                        },
                        color: AppColor.primaryColor,
                        borderColor:AppColor.primaryColor,
                        buttonText: "Verify",
                        textColor: isFilled ? Colors.black : Colors.black87),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
