import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/button.dart';

class InviteManager extends StatelessWidget {
  const InviteManager({super.key});

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
                      child:
                      Icon(CupertinoIcons.back, color: Colors.white, size: 30),
                    )
                  ],
                ),
                Gap(32),
                Image.asset("assets/Team_Leader/invite_manager.png"),
                Gap(32),
                customText(
                  text: "Invite Manager to Your Organization",
                  textsize: 24,
                  fontweight: FontWeight.w400,
                  color: Color(0xFFFFFFFF),
                ),
                Gap(32),
                textfield(
                  hint: "Enter Manager email",
                  icon: Icons.email_outlined,
                ),
                Gap(32),
                button(
                    onPressed: () {},
                    color: AppColor.primaryColor,
                    borderColor: AppColor.primaryColor,
                    buttonText: "Send Invite",
                    textColor: Colors.black)
              ],
            ),
          )),
    );
  }
}
