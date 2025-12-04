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
import '../../add team leader/view/add_to_department.dart';

class AddDepartment extends StatefulWidget {
  AddDepartment({super.key});

  @override
  State<AddDepartment> createState() => _ShowDialogComDepState();
}

class _ShowDialogComDepState extends State<AddDepartment> {
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
              text: "Add Department to Company",
              color: Colors.white,
              textsize: 22,
              fontweight: FontWeight.w400,
            ),

            Gap(32),

            ///add department
            EnterDepartment(),
            Gap(32),
            button(
              color: Color(0xFF060B1B),
              buttonText: "Continue",
              textColor: AppColor.primaryColor,
              borderColor: AppColor.primaryColor,
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AddToDepartment(),));},
            ),
            Gap(16),
          ],
        ),
      )),
    );
  }
}
