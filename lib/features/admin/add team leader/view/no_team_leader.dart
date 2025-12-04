import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/add%20team%20leader/view/send_to_teamLeader.dart';
import 'package:recomind/features/admin/add%20team%20leader/widget/members_cards.dart';
import 'package:recomind/features/admin/add%20team%20leader/widget/team_leader_card.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class NoTeamLeader extends StatelessWidget {
  NoTeamLeader({super.key});

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
            Gap(40),

            ///image
            Container(
              height: 200,
              width: 200,
                child: SvgPicture.asset("assets/Home/SVG_Icon/X.svg")),
            Gap(32),

            
            ///lable
            Row(
              children: [
                customText(text: "No members here\nadd a leader to get started",textsize: 22,fontweight: FontWeight.w400,color: Colors.white,),
              ],
            ),
            Gap(32),

            ///Button
            button(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SendToTeamleader(),));},
                color: AppColor.primaryColor,
                borderColor: AppColor.primaryColor,
                buttonText: "Invite Team Leader",
                textColor: Colors.black
            )
          ],
        ),
      )),
    );
  }
}
