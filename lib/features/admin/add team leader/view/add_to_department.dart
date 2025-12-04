import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/enter_department.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../shared/widgets/button.dart';
import '../../../../../shared/widgets/textfiekd.dart';
import '../../../../../shared/widgets/title_Text_Field.dart';
import 'TL_email.dart';

class AddToDepartment extends StatefulWidget {
  AddToDepartment({super.key});

  @override
  State<AddToDepartment> createState() => _ShowDialogComDepState();
}

class _ShowDialogComDepState extends State<AddToDepartment> {
  final ValueNotifier<String?> _selectedCountryNotifier =
  ValueNotifier<String?>("EGYPT");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Gap(70),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                          size: 30,
                        )),
                  ],
                ),
                Gap(32),

                ///title

                customText(
                  text: "Add Team Leaders to Departments",
                  color: Colors.white,
                  textsize: 20,
                  fontweight: FontWeight.w400,
                ),

                Gap(32),
                button(
                  color: AppColor.primaryColor,
                  buttonText: "Assign to Department",
                  textColor: Colors.black,
                  borderColor: AppColor.primaryColor,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TlEmail(),));
                  },
                ),
                Gap(27),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    },
                  child:customText(text: "Skip",color: AppColor.primaryColor,textsize: 16,fontweight: FontWeight.w400,isunderline: true,)
                )
              ],
            ),
          )),
    );
  }
}
