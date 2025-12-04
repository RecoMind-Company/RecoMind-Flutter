import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/Home_admin/widget/home_wid.dart';
import 'package:recomind/features/admin/profile/view/profile_view.dart';
import 'package:recomind/root.dart';
import 'package:recomind/screens/Admin/Home/Comany/com_screen.dart';
import 'package:recomind/screens/Admin/Home/invites/invite_screen.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class HomeViewAdmin extends StatefulWidget {
  const HomeViewAdmin({super.key});

  @override
  State<HomeViewAdmin> createState() => _HomeViewAdminState();
}

class _HomeViewAdminState extends State<HomeViewAdmin> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
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
              stops: [
                0.0001,
                0.02,
                0.12
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(70),
            // Profile header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView(),));
                    }
                    ,
                    child: const CircleAvatar(
                      radius: 23,
                      backgroundImage: AssetImage("assets/Home/Ellipse 79.png"),
                    ),
                  ),
                  Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      customText(
                        text: 'Welcome to CName, Ahmed!',
                            color: Color(0XFFEEEEEE),
                            fontweight: FontWeight.bold,
                            textsize: 18,),
                      Gap(2),
                      customText(
                        text: 'Moving forward together',
                       color: Colors.white54, textsize: 14),
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
                        color: AppColor.primaryColor, size: 28),
                  ),
                ],
              ),
            ),

            Gap(50),

            // Stats card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF0077A8),
                        Color(0xFF003B57),
                        Color(0xFF070C1E),
                      ],
                      stops: [
                        0.0001,
                        0.03,
                        0.20
                      ]),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Image(
                          image: AssetImage(
                              "assets/Home/fluent_people-team-20-regular.png")),
                    ),
                    Gap(20),
                    SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          StatColumn(label: 'Accepted Invites', value: '9'),
                          VerticalDivider(
                            color: Color(0xff2F5368),
                            width: 2,
                            endIndent: 16,
                            indent: 16,
                          ),
                          StatColumn(label: 'Expired Invites', value: '6'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const customText(
                      text: "10 members haven't joined yet",
                          color: Color(0xffEFEFEF),
                          textsize: 20,
                    ),
                   Gap(16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7EE3FF),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 8,
                        ),
                        child: const customText(
                          text: 'Track Invites',
                              color: Colors.black,
                              fontweight: FontWeight.bold,
                              textsize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

          ],
        ),
      ),
    );
  }
}



