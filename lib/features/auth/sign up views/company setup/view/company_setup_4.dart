import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_5.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/invite_TL.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/company_diver.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/header_all_company.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/upload_Button2.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';

class CompanySetup4 extends StatelessWidget {
  const CompanySetup4({super.key});

  final int Pagenumber = 3;

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
              HeaderAllCompany(Pagenumber: Pagenumber),
              Gap(16),
              customText(
                text: "Invite Team Leaders & Manager",
                color: Colors.white,
                fontweight: FontWeight.w400,
                textsize: 23,
              ),
              Gap(24),

              /// DESCRIPTION
              Gap(8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    ///description
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                              text: "Managers Emails",
                              color: Color(0xFFEFEFEF),
                              fontweight: FontWeight.w400,
                              textsize: 16,
                            ),
                            customText(
                              text:
                                  "Enter all manager emails separated by commas",
                              color: Color(0xFFC2C2C2),
                              fontweight: FontWeight.w500,
                              textsize: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(8),

                    ///textfield
                    textfield(
                      hint: "manager1@company.com, manager2@com",
                      icon: Icons.mail_outline_outlined,
                    ),
                    Gap(24),

                    ///description
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                              text: "Invite Team Leaders",
                              color: Color(0xFFEFEFEF),
                              fontweight: FontWeight.w400,
                              textsize: 16,
                            ),
                            customText(
                              text:
                                  "Assign your Team Leaders by uploading an Excel sheet or entering\ntheir emails manually . ",
                              color: Color(0xFFC2C2C2),
                              fontweight: FontWeight.w500,
                              textsize: 10,
                              iscenter: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(8),

                    ///upload button 2
                    UploadButton2(),
                    Gap(16),

                    ///diver
                    CompanyDiver(
                      text: "or",
                      width: 170,
                    ),
                    Gap(16),

                    ///Manually
                    GestureDetector(
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => InviteTl(),));
                      },
                        child: customText(
                      text: "Assign to Departments Manually",
                      textsize: 14,
                      fontweight: FontWeight.w400,
                      color: AppColor.primaryColor,
                      isunderline: true,
                    ),),
                    Gap(32),

                    ///buttons
                    button(
                      color: AppColor.primaryColor,
                      buttonText: "Next",
                      textColor: Colors.black,
                      borderColor: AppColor.primaryColor,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CompanySetup5(),));
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
          ),
        ),
      ),
    );
  }
}
