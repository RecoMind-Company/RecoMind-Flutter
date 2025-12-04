import 'package:flutter/material.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_1.dart';
import 'package:recomind/shared/widgets/button.dart';

class AlmostButton extends StatelessWidget {
  const AlmostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: button(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompanySetup1()));
            },
            color: AppColor.primaryColor,
            borderColor: AppColor.primaryColor,
            buttonText: "Build Your Company",
            textColor: Colors.black));
  }
}
