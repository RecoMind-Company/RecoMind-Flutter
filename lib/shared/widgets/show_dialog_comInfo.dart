import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_colors.dart';
import 'button.dart';
import 'textfiekd.dart';
import 'title_Text_Field.dart';
import '../../features/auth/sign up views/company setup/widgets/dropDown.dart';


class ShowDialogCominfo extends StatefulWidget {
   ShowDialogCominfo({super.key,required this.ontap});
  Function() ontap;
  @override
  State<ShowDialogCominfo> createState() => _ShowDialogCominfoState();
}

class _ShowDialogCominfoState extends State<ShowDialogCominfo> {
  final TextEditingController _business_Industry_Controller = TextEditingController();
  final TextEditingController _Country_Controller = TextEditingController();
  final TextEditingController _Company_Size_Controller = TextEditingController();
  final ValueNotifier<String?> _selectedCountryNotifier =
  ValueNotifier<String?>("EGYPT");

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.transparent.withOpacity(0.2),
        child: Column(
          children: [
            Gap(200),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 23),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF060B1B),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(29),
                      Container(
                        width: 154,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap:widget.ontap,
                            child: Icon(
                              CupertinoIcons.xmark,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(8)
                        ],
                      ),
                      Gap(24),

                      Column(
                        children: [
                          Column(
                            children: [
                              TitleTextField(
                                text: "Business Industry",
                              ),
                              Dropdown(
                                controller: _business_Industry_Controller,
                                items: ["Marketing","Sales","IT","HR"],
                                selectedItem: _selectedCountryNotifier,
                                hints: "EX : Marketing",
                              ),
                            ],
                          ),
                          Gap(16),
                          Column(
                            children: [
                              TitleTextField(
                                text: "Country",
                              ),
                              Dropdown(
                                controller: _Country_Controller,
                                items: ["Egypt","USA","Qatar","Japan"],
                                selectedItem: _selectedCountryNotifier,
                                hints:"Search Country" ,
                              ),
                            ],
                          ),
                          Gap(16),
                          Column(
                            children: [
                              TitleTextField(
                                text: "Company Size",
                              ),
                              Dropdown(
                                controller: _Company_Size_Controller,
                                items: ["50-100","100-200","200-500"],
                                selectedItem: _selectedCountryNotifier,
                                hints: "200-500",
                              ),
                            ],
                          ),
                          Gap(16),
                          Column(
                            children: [
                              TitleTextField(
                                text: "Company Website",
                              ),
                              textfield(
                                hint: "Example",
                              ),
                            ],
                          ),
                          Gap(16),
                          Column(children: [
                            TitleTextField(
                              text: "Company Website",
                            ),
                            Gap(4),
                            textfield(hint: "https://company.org"),
                            Gap(16),
                            TitleTextField(
                              text: "Business Description",
                            ),Gap(4),
                            TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: "Describe your company’s purpose, services, and goals…",
                                  hintStyle: const TextStyle(
                                      color: Color(0xFFB8ADAD), fontFamily: "Poppins" , fontSize: 14),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffEFEFEF),width: 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  focusedBorder:OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffEFEFEF),width: 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  contentPadding: const EdgeInsets.symmetric( vertical: 17,horizontal: 20),
                                )
                            ),
                            Gap(34),
                            button(onPressed: (){}, color: AppColor.primaryColor, borderColor: AppColor.primaryColor, buttonText: "Save", textColor: Colors.black)
                            ,Gap(25)
                          ],),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
