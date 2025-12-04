import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/widget/card_management.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../../add TL & manager/view/invite_TL.dart';

class ViewAlAdmin extends StatelessWidget {
   ViewAlAdmin({super.key});
  final List names = ["Khaled Omar", "Aya Omar", "Ahmed Omar","Omar mohammed"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(70),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(CupertinoIcons.back, color: Colors.white, size: 30),
                  ),
                ],
              ),
              Gap(48),
              ///add admins
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                    text: "Admins",
                    textsize: 28,
                    fontweight: FontWeight.w500,
                    color: const Color(0xFFFFFFFF),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InviteTl(),));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            CupertinoIcons.plus,
                            fontWeight: FontWeight.bold,
                          ),
                          const Gap(5),
                          customText(
                            text: 'Invite Admin',
                            textsize: 14,
                            fontweight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Gap(32),
              Column(
                children: List.generate(names.length,(index) {
                  return Column(children: [
                    index != 0 ? Divider(
                      color: Color(0xFF03294A),
                      thickness: 1,) : customText(text: ""),
                    Gap(16),
                    CardManagement(gmail_copy: "Aya@gmail.com",Name: names[index],),
                    Gap(16)

                  ],);
                },)
              ),
              Gap(30)


            ],
          ),
        ),
      )),
    );
  }
}
