import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/company%20Admin/widget/com_info_admin.dart';
import 'package:recomind/features/admin/company%20Admin/widget/show_dialog_admin.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/view/database_setup.dart';
import 'package:recomind/features/admin/profile/view/profile_view.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/widget/com_info.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/widget/edit_button.dart';
import 'package:recomind/screens/Admin/Home/Home_page.dart';
import 'package:recomind/screens/Admin/Home/invites/invite_screen.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/show_dialog_comInfo.dart';

import '../../company members & DB/view/company_members.dart';



class CompanyView extends StatefulWidget {
  const CompanyView({super.key});

  @override
  State<CompanyView> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyView> {
 bool isclicked_info = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0077A8),
                  Color(0xFF003B57),
                  Color(0xFF060B1B),
                ],
                stops: [0.0001, 0.02, 0.120],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Gap(70),

                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView(),));
                }
                        ,child: const CircleAvatar(
                          radius: 23,
                          backgroundImage: AssetImage("assets/Home/Ellipse 79.png"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          customText(
                             text: 'Welcome to CName, Ahmed!',
                              color: Color(0XFFEEEEEE),
                              fontweight: FontWeight.bold,
                              textsize: 18,
                          ),
                          Gap(2),
                          customText(
                            text: 'Moving forward together',
                            color: Colors.white54, textsize: 14
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF060B1B),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.notifications_none,
                            color: Color(0xff65B7D1), size: 28),
                      ),
                    ],
                  ),
                ),

                Gap(50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: "Company info",
                          textsize: 20,
                          fontweight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        EditButton(
                          ontap: () {
                            setState(() {
                              isclicked_info = true;
                            });
                          },
                        ),
                      ],
                    ),
                    Gap(16),

                    ///info
                    ComInfoAdmin(
                      title: "company Name",
                      name: "CName",
                    ),
                  Row(
                    children: [
                      customText(
                        text: "Company Description",
                        fontweight: FontWeight.w400,
                        textsize: 12,
                        color: Color(0xFFB5B5B5),
                      ),
                    ],
                  ),
                  Gap(4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text:
                        """Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor incididunt""",
                        textsize: 14,
                        fontweight: FontWeight.w400,
                        color: Color(0xFFFFFFFF),
                      ),
                      Row(
                        children: [
                          customText(
                            text: """ut labore et dolore magna...""",
                            textsize: 14,
                            fontweight: FontWeight.w400,
                            color: Color(0xFFFFFFFF),
                          ),
                          Gap(5),
                          GestureDetector(
                              onTap: () {},
                              child: customText(
                                text: "Read More",
                                color: AppColor.primaryColor,
                                fontweight: FontWeight.w400,
                                textsize: 14,
                                isunderline: true,
                              ))
                        ],
                      ),
                    ],
                  ),
                    Gap(16)
                    ,
                    ComInfoAdmin(
                      title: "Industry",
                      name: "Software Development",
                    ),
                    ComInfoAdmin(
                      title: "Country",
                      name: "Egypt",
                    ),
                    ComInfoAdmin(
                      title: "Company Size",
                      name: "200 - 500",
                    ),
                    Gap(32),

                    ///DB setup
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DatabaseSetup(),));
                      },
                      child: Container(
                        height: 48,
                        width: 343,
                        color: Colors.transparent,
                        child: Row(
                          children: [
                             Icon(FeatherIcons.database , color: Color(0xFFEEEEEE),),
                            Gap(23),
                            customText(text: "Database Setup",textsize: 18,fontweight: FontWeight.w500,color: Color(0xFFFFFFFF),),
                            Spacer(),
                            SvgPicture.asset("assets/Home/next.svg")
                          ],
                        ),
                      ),
                    ) ,
                    Gap(32),


                    ///Members
                    GestureDetector(
                      onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CompanyMembers()));
                    },
                      child: Container(
                        height: 48,
                        width: 343,
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/Home/SVG_Icon/members.svg"),
                            Gap(23),
                            customText(text: "Members",textsize: 18,fontweight: FontWeight.w500,color: Color(0xFFFFFFFF),),
                            Spacer(),
                            SvgPicture.asset("assets/Home/next.svg")
                          ],
                        ),
                      ),
                    )


                  ],),
                ),
              ],
            ),
          ),
          isclicked_info == true ? ShowDialogCominfo(ontap: (){setState(() {
            isclicked_info = false;
          });},):customText(text: "")
        ],
      ),
    );
  }
}
