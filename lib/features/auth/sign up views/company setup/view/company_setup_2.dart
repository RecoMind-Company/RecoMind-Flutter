import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_3.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/company_diver.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/header_all_company.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/multi_lins_textfield.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/upload_Button.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/diver_wid.dart';

class CompanySetup2 extends StatelessWidget {
  const CompanySetup2({super.key});

  final int PageNumber = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Containerwid(
            child: Column(
          children: [
            HeaderAllCompany(Pagenumber: PageNumber),
            Gap(40),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Business Description",
                        color: Color(0xFFEFEFEF),
                        fontweight: FontWeight.w400,
                        textsize: 16,
                      ),
                      customText(
                        text:
                            "You can write a short description or upload a file",
                        color: Color(0xFFEFEFEF),
                        fontweight: FontWeight.w500,
                        textsize: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  MultiLinsTextfield(),
                  Gap(20),
                  CompanyDiver(width: 75,text: "Or upload your company profile",),
                  Gap(16),
                  UploadButton(),
                  Gap(30),
                  button(
                    color: AppColor.primaryColor,
                    buttonText: "Next",
                    textColor: Colors.black,
                    borderColor: AppColor.primaryColor,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CompanySetup3(),));
                    },
                  ),
                  Gap(16),
                  button(
                    color: Color(0xFF060B1B),
                    buttonText: "Back",
                    textColor: AppColor.primaryColor,
                    borderColor: AppColor.primaryColor,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
