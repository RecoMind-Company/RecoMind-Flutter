import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/view/view_al_Admin.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/view/view_all_managers.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/widget/card_management.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../../add TL & manager/view/invite_Manager.dart';
import '../../add TL & manager/view/invite_TL.dart';


class ManagementView extends StatefulWidget {
  const ManagementView({super.key});

  @override
  State<ManagementView> createState() => _ManagementViewState();
}

class _ManagementViewState extends State<ManagementView> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32),
      child: Column(
        children: [
          ///add admin
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                text: "Admins",
                textsize: 18,
                fontweight: FontWeight.w400,
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
                        text: 'Add',
                        textsize: 14,
                        fontweight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const Gap(16),
          CardManagement(gmail_copy: "Aya@gmail.com",Name: "Aya Omar",),
          const Gap(27),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAlAdmin(),));},child: customText(text: "View All",color: AppColor.primaryColor,textsize: 14,fontweight: FontWeight.w500,isunderline: true,))],)
           ,Gap(20),

          ///diver
          Divider(
            color: Color(0xFF03294A),
            thickness: 1,),
          Gap(40),

          ///add team leader
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                text: "Managers",
                textsize: 18,
                fontweight: FontWeight.w400,
                color: const Color(0xFFFFFFFF),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InviteManager(),));
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
                        text: 'Add',
                        textsize: 14,
                        fontweight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const Gap(16),
          CardManagement(gmail_copy: "Aya@gmail.com",Name: "Aya Omar",),
          const Gap(27),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllManagers(),));},child: customText(text: "View All",color: AppColor.primaryColor,textsize: 14,fontweight: FontWeight.w500,isunderline: true,))],)
          ,Gap(20),

        ],
      ),
    );
  }
}