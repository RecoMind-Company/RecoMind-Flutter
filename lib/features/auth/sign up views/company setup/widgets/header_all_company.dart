import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/header_company_setup.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class HeaderAllCompany extends StatelessWidget {
  const HeaderAllCompany({super.key , required this.Pagenumber});
  final int Pagenumber ;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Gap(70),
      customText(
        text: "Company Setup",
        textsize: 30,
        color: Color(0xFFEEEEEE),
        fontweight: FontWeight.w400,
      ),
      Gap(25),
      HeaderCompanySetup(
        pageNumber: Pagenumber,
      ),
    ],);
  }
}
