import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_2.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/dropDown.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/header_all_company.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/header_company_setup.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/title_Text_Field.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';

class CompanySetup1 extends StatefulWidget {
  const CompanySetup1({super.key});

  @override
  State<CompanySetup1> createState() => _CompanySetup1State();
}

class _CompanySetup1State extends State<CompanySetup1> {
  final int Pagenumber = 0;
  String _selectedCountry = "Egypt";
  final ValueNotifier<String?> _selectedCountryNotifier = ValueNotifier<String?>("EGYPT");
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Containerwid(
            child: Stack(
          children: [
            Column(
              children: [
                ///head
                HeaderAllCompany(
                  Pagenumber: Pagenumber,
                ),
                Gap(16),
                customText(
                  text: "Company Profile",
                  color: Color(0xFFEFEFEF),
                  fontweight: FontWeight.w400,
                  textsize: 24,
                ),
                Gap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      TitleTextField(
                        text: "Company Name",
                      ),
                      textfield(
                        hint: "Example",
                      ),
                      Gap(15),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                top: 780,
                left: 18,
                right: 18,
                child: button(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanySetup2(),
                        ));
                  },
                  color: AppColor.primaryColor,
                  borderColor: AppColor.primaryColor,
                  textColor: Colors.black,
                  buttonText: "Next",
                )),
            Positioned(
                top: 655,
                left: 18,
                right: 18,
                child: Column(
                  children: [
                    TitleTextField(
                      text: "Company Website",
                    ),
                    textfield(
                      hint: "Example",
                    ),
                  ],
                )),
            Positioned(
                top: 545,
                left: 18,
                right: 18,
                child: Column(
                  children: [
                    TitleTextField(
                      text: "Company Size",
                    ),
                    Dropdown(
                      selectedCountry: _selectedCountryNotifier,
                    ),
                  ],
                )),
            Positioned(
                top: 435,
                left: 18,
                right: 18,
                child: Column(
                  children: [
                    TitleTextField(
                      text: "Country",
                    ),
                    Dropdown(
                      selectedCountry:_selectedCountryNotifier,
                    ),
                  ],
                )),
            Positioned(
                top: 320,
                left: 18,
                right: 18,
                child: Column(
                  children: [
                    TitleTextField(
                      text: "Business Industry",
                    ),
                    Dropdown(
                      selectedCountry: _selectedCountryNotifier,
                    ),
                  ],
                )),
          ],
        )),
      ),
    );
  }
}
