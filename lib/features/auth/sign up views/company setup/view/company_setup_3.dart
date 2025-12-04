import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_4.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/enter_department.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/header_all_company.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class CompanySetup3 extends StatefulWidget {
  const CompanySetup3({super.key});

  @override
  State<CompanySetup3> createState() => _CompanySetup3State();
}

class  _CompanySetup3State extends State<CompanySetup3> {
  final int Pagenumber = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0077A8),
                    Color(0xFF003B57),
                    Color(0xFF060B1B),
                  ],
                  stops: [
                    0.0001,
                    0.02,
                    0.20
                  ]),
            ),
            padding: const EdgeInsets.fromLTRB(20,0, 20, 20),
            child: Column(
              children: [
                ///head
                HeaderAllCompany(Pagenumber: Pagenumber),
                Gap(32),
                ///title
                Row(
                  children: [
                    customText(
                      text: "Add Department to Company",
                        color: Colors.white,
                        textsize: 16,
                        fontweight: FontWeight.w400,
                    ),
                  ],
                ),
               Gap(8),
                
                
                ///add department
                EnterDepartment(),
               Gap(32),
                button(
                  color: AppColor.primaryColor,
                  buttonText: "Next",
                  textColor: Colors.black,
                  borderColor: AppColor.primaryColor,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CompanySetup4(),));
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
            )));
  }
}
