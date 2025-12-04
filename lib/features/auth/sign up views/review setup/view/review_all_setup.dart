import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/dropDown.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/widget/DB_info.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/widget/com_info.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/widget/department.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/widget/edit_button.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/start_AI_processing.dart';
import 'package:recomind/shared/widgets/show_dialog_comInfo.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';
import 'package:recomind/shared/widgets/title_Text_Field.dart';

import '../../plan & complete/view/plan.dart';
import '../widget/show_dialog_dep.dart';

class ReviewAllSetup extends StatefulWidget {
  ReviewAllSetup({super.key});

  @override
  State<ReviewAllSetup> createState() => _ReviewAllSetupState();
}

class _ReviewAllSetupState extends State<ReviewAllSetup> {
  final List depList = ['Sales', 'marketing', 'Sales'];
  final ValueNotifier<String?> _selectedCountryNotifier =
      ValueNotifier<String?>("EGYPT");
late bool isclicked_info ;
late bool isclicked_dep ;
  @override
  void initState() {
     isclicked_info=false ;
     isclicked_dep= false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Containerwid(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(70),

                  ///title
                  customText(
                    text: "Review Setup",
                    fontweight: FontWeight.w400,
                    textsize: 28,
                    color: Color(0xFFEEEEEE),
                  ),
                  Gap(10),

                  ///subtitle
                  Row(
                    children: [
                      customText(
                        text:
                            "Check your company details before completing\nthe setup.",
                        fontweight: FontWeight.w400,
                        textsize: 13,
                        color: Color(0xFFEEEEEE),
                        iscenter: false,
                      ),
                    ],
                  ),
                  Gap(20),

                  ///Company info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: "Company info",
                        textsize: 20,
                        fontweight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      EditButton(
                        ontap: () {
                          setState(() {
                            isclicked_info = true;
                          });
                        },
                      ),
                    ],
                  ),
                  Gap(15),

                  ///info
                  ComInfo(
                    title: "company Name",
                    name: "CName",
                  ),
                  ComInfo(
                    title: "Industry",
                    name: "Software Development",
                  ),
                  ComInfo(
                    title: "Country",
                    name: "Egypt",
                  ),
                  ComInfo(
                    title: "Company Size",
                    name: "200 - 500",
                  ),
                  Row(
                    children: [
                      customText(
                        text: "Company Description",
                        fontweight: FontWeight.w400,
                        textsize: 12,
                        color: Color(0xFFB5B5B5),
                      ),
                    ],
                  ),
                  Gap(4),
                  Column(
                    children: [
                      customText(
                        text:
                            """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt""",
                        textsize: 14,
                        fontweight: FontWeight.w400,
                        color: Color(0xFFFFFFFF),
                      ),
                      Row(
                        children: [
                          customText(
                            text: """ut labore et dolore magna...""",
                            textsize: 14,
                            fontweight: FontWeight.w400,
                            color: Color(0xFFFFFFFF),
                          ),
                          Gap(5),
                          GestureDetector(
                              onTap: () {},
                              child: customText(
                                text: "View full description",
                                color: AppColor.primaryColor,
                                fontweight: FontWeight.w400,
                                textsize: 14,
                                isunderline: true,
                              ))
                        ],
                      ),
                    ],
                  ),
                  Gap(24),
                  Divider(
                    color: Color(0xFF03294A),
                    thickness: 1,
                  ),
                  Gap(24),

                  ///DEPARTMENT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: "Department",
                        textsize: 20,
                        fontweight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      EditButton(
                        ontap: () {setState(() {
                          isclicked_dep = !isclicked_dep;
                        });},
                      ),
                    ],
                  ),
                  Gap(15),
                  Department(
                    depList: depList,
                  ),
                  Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      customText(
                        text: "+3 more departments",
                        color: AppColor.primaryColor,
                        fontweight: FontWeight.w400,
                        textsize: 12,
                      ),
                    ],
                  ),
                  Gap(24),
                  Divider(
                    color: Color(0xFF03294A),
                    thickness: 1,
                  ),
                  Gap(24),

                  ///DB_Setup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: "Database Setup",
                        textsize: 20,
                        fontweight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      EditButton(
                        ontap: () {},
                      ),
                    ],
                  ),
                  Gap(15),
                  DbInfo(title: "Server", name: "CName"),
                  Gap(8),
                  Divider(
                    color: Color(0xFF03294A),
                    thickness: 1,
                  ),
                  Gap(8),
                  DbInfo(title: "Database Name", name: "CompanyDB"),
                  Gap(8),
                  Divider(
                    color: Color(0xFF03294A),
                    thickness: 1,
                  ),
                  Gap(8),
                  DbInfo(title: "User ID", name: "admin"),
                  Gap(32),

                  ///button
                  button(
                      onPressed: () {
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartAiProcessing(),));
                      },
                      color: AppColor.primaryColor,
                      borderColor: AppColor.primaryColor,
                      buttonText: "Finish Setup",
                      textColor: Colors.black),
                  Gap(30)
                ],
              ),
            ),
          )),
          isclicked_info == true
              ?
          ShowDialogCominfo(
                  ontap: () {
                    setState(() {
                      isclicked_info = false;
                    });
                  },
                ): Text(""),
          isclicked_dep ==true ? ShowDialogComDep(list: depList,ontap: (){setState(() {
            isclicked_dep = false;
          });},) : Text(""),
        ],
      ),
    );
  }
}
