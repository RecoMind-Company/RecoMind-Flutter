import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';



class TeamLeaderCard extends StatelessWidget {
  const TeamLeaderCard({super.key});
  void _copyEmail(BuildContext context) {
    Clipboard.setData(ClipboardData(text: "Aya@gmail.com")).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Copied!"),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey<bool>(true),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF212635),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(children: [

            customText(
              text: "Aya Omar",
              fontweight: FontWeight.w400,
              textsize: 18,
              color: const Color(0xFFFFFFFF),
            ),
          ]),
          const Gap(15),
          Row(
            children: [
              customText(
                text: "Email :",
                color: CupertinoColors.inactiveGray,
              ),
              const Gap(5),
              customText(
                text: "Aya@gmail.com",
                color: CupertinoColors.inactiveGray,
              )
            ],
          ),
          const Gap(20),
          button(
              onPressed: () => _copyEmail(context),
              color: const Color(0xFF212635),
              borderColor: AppColor.primaryColor,
              buttonText: "Copy Email",
              textColor: AppColor.primaryColor)
        ],
      ),
    );
  }
}
