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

class TlEmail extends StatefulWidget {
  TlEmail({super.key});

  @override
  State<TlEmail> createState() => _ShowDialogComDepState();
}

class _ShowDialogComDepState extends State<TlEmail> {
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

                Row(
                  children: [
                    customText(
                      text: "Marketing Department",
                      color: Colors.white,
                      textsize: 16,
                      fontweight: FontWeight.w400,
                    ),
                  ],
                ),
                Gap(8),
                
                textfield(hint: "Team Leader email",icon: Icons.email_outlined,),
                
                Gap(32), 
                button(
                  color: AppColor.primaryColor,
                  buttonText: "Invite Leaders",
                  textColor: Colors.black,
                  borderColor: AppColor.primaryColor,
                  onPressed: () {},
                ),
                Gap(8),
                Row(children: [
                  Icon(Icons.error_outline,color: Colors.white,),
                  Gap(5),
                  customText(text: "All leaders will receive invites via email",color: Colors.white,fontweight: FontWeight.w500,textsize: 12,)
                ],),
                Gap(27),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child:customText(text: "Skip",color: AppColor.primaryColor,textsize: 16,fontweight: FontWeight.w400,isunderline: true,)
                ),
                Gap(130),
                Image.asset("assets/Home/email_image_icon.com.png")
              ],
            ),
          )),
    );
  }
}






















