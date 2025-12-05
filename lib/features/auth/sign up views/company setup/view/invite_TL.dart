import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';
import 'package:recomind/shared/widgets/title_Text_Field.dart';


class InviteTl extends StatelessWidget {
  const InviteTl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            ///back icon
            Gap(73),
            Row(
              children: [
                Gap(5),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(CupertinoIcons.back, color: Colors.white,size: 30,),
                ),
              ],
            ),
            Gap(32),

            ///text field
            TitleTextField(text: "Marketing Department",),
            Gap(8),
            textfield(hint: "Team Leader email",icon: Icons.mail_outline_outlined,) ,

            ///diver
            Gap(24),
            Divider(
              color: Color(0xFF03294A),
              thickness: 1,),
            Gap(16),

            TitleTextField(text: "Sales Department",),
            textfield(hint: "Team Leader email",icon: Icons.mail_outline_outlined,) ,
            Gap(32),

            button(onPressed: (){}, color: AppColor.primaryColor, borderColor: AppColor.primaryColor, buttonText: "Invite Leaders", textColor: Colors.black),
            Gap(8),
            Row(
              children: [
                Icon(Icons.error_outline,color: Colors.white,),
                Gap(8),
                customText(text: "All leaders will receive invites via email",fontweight: FontWeight.w500,textsize: 12,color: Colors.white,),
              ],
            )

          ],
        ),
      ),)
    );
  }
}
