import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/add%20team%20leader/widget/members_cards.dart';
import 'package:recomind/features/admin/add%20team%20leader/widget/team_leader_card.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class MarktingDepartment extends StatelessWidget {
   MarktingDepartment({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

            ///Team Leader
            customText(
              text: "Marketing Members : 12",
              color: Colors.white,
              fontweight: FontWeight.w400,
              textsize: 22,
            ),
            Gap(4),
            customText(
              text: "Team Leader",
              fontweight: FontWeight.w400,
              textsize: 14,
              color: Color(0xFFB5B5B5),
            ),
            Gap(8),
            TeamLeaderCard(),
            Gap(24),

            ///members
            customText(
              text: "Members",
              fontweight: FontWeight.w400,
              textsize: 14,
              color: Color(0xFFB5B5B5),
            ),
            Gap(8),
            MembersCards()
          ],
        ),
      )),
    );
  }
}
