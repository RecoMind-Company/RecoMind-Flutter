import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_model.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/data/review_Model.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/view/review_all_setup.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class CompanySetupSuccess extends StatelessWidget {
  const CompanySetupSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Gap(149),

              /// success image
              Image.asset("assets/complete.png"),
              Gap(36),

              /// description
              Column(
                children: [
                  customText(
                    text: "Company Setup Completed Successfully!",
                    textsize: 24,
                    fontweight: FontWeight.w400,
                    color: Color(0xFFEFEFEF),
                    iscenter: true,
                  ) , 
                  Gap(8),
                  customText(
                    text: "Your company information has been saved.",
                    textsize: 15,
                    fontweight: FontWeight.w400,
                    color: Color(0xFFEFEFEF),
                    iscenter: true,
                  )
                ],
              ) ,
              Gap(32),

              /// button
              button(
                color: AppColor.primaryColor,
                buttonText: "Go to Review",
                textColor: Colors.black,
                borderColor: AppColor.primaryColor,
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReviewAllSetup(),));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
