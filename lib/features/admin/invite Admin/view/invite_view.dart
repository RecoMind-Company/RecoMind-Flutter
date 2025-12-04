import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/admin/invite%20Admin/widget/invite_successfully_message.dart';
import 'package:recomind/features/admin/profile/view/profile_view.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../widget/invite_card.dart' show InviteCard;

class InviteView extends StatefulWidget {
  const InviteView({super.key});

  @override
  State<InviteView> createState() => _InvitesScreenState();
}

class _InvitesScreenState extends State<InviteView> {
bool isInvite = false ;

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
                           text:'Welcome to CName, Ahmed!',
                              color: Color(0XFFEEEEEE),
                              fontweight: FontWeight.bold,
                              textsize: 18,
                          ),
                          Gap(2),
                          customText(
                            text: 'Moving forward together', color: Colors.white54, textsize: 14),
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

                Gap(40),

                /// Expired Invites
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: customText(
                    text: "Expired Invites",
                        color: Colors.white,
                        textsize: 16,
                        fontweight: FontWeight.w600),
                ),
                Gap(12),

                InviteCard(
                  ontap: (){
                    setState(() {
                      isInvite = true ;
                    });
                  },
                  name: "Noreen Motaz",
                  status: "Expired",
                  statusColor: const Color(0xFFD65C5C),
                  buttonText: "Invite by Email",
                ),
                InviteCard(
                  ontap: (){setState(() {
                    isInvite = true ;
                  });},
                  name: "Aya Omar",
                  status: "Expired",
                  statusColor: const Color(0xFFD65C5C),
                  buttonText: "Invite by Email",
                ),

                Gap(25),
                /// pending cards
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: customText(
                    text: "Pending Invites",
                        color: Colors.white,
                        textsize: 16,
                        fontweight: FontWeight.w600),
                ),
                Gap(12),
                InviteCard(
                  ontap: (){},
                  name: "Noor Mohammed",
                  status: "Pending",
                  statusColor: const Color(0xFFE8D95B),
                  subText: "Invitation expires in 4 days",
                  buttonVisible: false,
                ),
                const Spacer(),

              ],
            ),
          ),

          /// success message
          isInvite != false ?InviteSuccessfullyMessage(ontap: (){setState(() {
            isInvite = false;
          });},):customText(text: "")
        ],
      ),
    );
  }
}



