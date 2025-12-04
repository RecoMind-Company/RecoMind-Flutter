import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';
import 'package:recomind/shared/widgets/title_Text_Field.dart';

class DatabaseSetup extends StatelessWidget {
  const DatabaseSetup({super.key});

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
                Gap(15),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 30,
                    )),
                Gap(40),
                customText(
                  text: "Database Setup",
                  textsize: 26,
                  fontweight: FontWeight.w400,
                  color: Colors.white,
                )
              ],
            ),
            Gap(32),
            TitleTextField(text: "Server"),
            Gap(4),
            textfield(hint: "Example"),
            Gap(16),
            TitleTextField(text: "Database"),
            Gap(4),
            textfield(hint: "Company DB"),
            Gap(32),
            button(
                onPressed: () {
                  /////////////////
                  Navigator.pop(context);
                },
                color: AppColor.primaryColor,
                borderColor: AppColor.primaryColor,
                buttonText: "Save",
                textColor: Colors.black)
          ],
        ),
      )),
    );
  }
}
