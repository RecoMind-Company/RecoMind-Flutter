import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/add%20team%20leader/widget/members_cards.dart';
import 'package:recomind/features/admin/add%20team%20leader/widget/team_leader_card.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';

class SendToTeamleader extends StatelessWidget {
  const SendToTeamleader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(70),
                Row(
                  children: [
                    Gap(8),
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


                ///image
              Image.asset("assets/Home/email_image_icon.com.png"),


                ///lable
                Row(
                  children: [
                    customText(text: "Enter the Team Leader email to send\nthe invite code",textsize: 18,fontweight: FontWeight.w400,color: Colors.white,),
                  ],
                ),
                Gap(32),
                textfield(hint: "example@email.com",icon: Icons.email_outlined),
                Gap(32),

                ///Button
                button(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    color: AppColor.primaryColor,
                    borderColor: AppColor.primaryColor,
                    buttonText: "Send",
                    textColor: Colors.black
                )
              ],
            ),
          )),
    );
  }
}
