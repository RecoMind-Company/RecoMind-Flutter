import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/profile/view/edit_view.dart';
import 'package:recomind/features/admin/profile/view/setting_view.dart';
import 'package:recomind/features/admin/profile/widget/show_logout_dialog.dart';
import 'package:recomind/features/auth/log%20in%20views/log%20in/view/log_in.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../../../auth/sign up views/review setup/widget/edit_button.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isLogout = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF060B1B),
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
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
                          size: 35,
                        )),
                    Gap(105),
                    customText(
                      text: "Profile",
                      color: Colors.white,
                      fontweight: FontWeight.w400,
                      textsize: 28,
                    )
                  ],
                ),
                Gap(39),

                ///Premium
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  height: 29,
                  width: 344,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: AlignmentGeometry.centerRight,
                          colors: [
                            Color(0xFF293F51),
                            Color(0xFF4C77A1),
                          ]),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Image.asset("assets/star.png"),
                      Gap(4),
                      customText(
                        text: "You’re on Premium plan enjoy all report types",
                        textsize: 12,
                        fontweight: FontWeight.w400,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Gap(32),

                ///edit button && image
                Container(
                  height: 101,
                  width: 344,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditButton(ontap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>EditView() ,));
                      },),
                      Spacer(),
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("assets/Home/man.png"),
                      )
                    ],
                  ),
                ),
                Gap(22),

                ///personal info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                      text: "Personal Info",
                      fontweight: FontWeight.w400,
                      textsize: 24,
                      color: Colors.white,
                    ),
                    Gap(12),
                    Row(children: [
                      Icon(Icons.edit,color: Color(0xFFB9B8B8),),
                      Gap(5),
                      customText(text: "Name :  Ahmed",textsize: 16,fontweight: FontWeight.w400,color:Color(0xFFB9B8B8) ,)
                    ],),
                    Gap(20),
                    Row(children: [
                      Icon(Icons.email_outlined,color: Color(0xFFB9B8B8),),
                      Gap(5),
                      customText(text: "Email :  Ahmed@gmail.com",textsize: 16,fontweight: FontWeight.w400,color:Color(0xFFB9B8B8) ,)
                    ],),
                    Gap(20),
                    Row(children: [
                      Icon(CupertinoIcons.phone,color: Color(0xFFB9B8B8),),
                      Gap(5),
                      customText(text: "Phone :  010565780",textsize: 16,fontweight: FontWeight.w400,color:Color(0xFFB9B8B8) ,)
                    ],),
                    Gap(30),
                    Divider(
                      color: Color(0xFF498495),
                      thickness: 1,),
                    Gap(20),
                    /// setting
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingView(),));
                      },
                      child: Container(
                        height: 48,
                        child: Row(children: [
                          Icon(Icons.settings,color: Color(0xFFB9B8B8),size: 30,),
                          Gap(23),
                          customText(text: "Settings",textsize: 16,fontweight: FontWeight.w400,color:Color(0xFFB9B8B8) ,)
                        ],),
                      ),
                    ),
                    Gap(10),
                    /// Logout
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isLogout = true;
                        });
                      },
                      child: Container(
                        height: 48,
                        child: Row(children: [
                          Icon(Icons.logout,color: Color(0xFFF76969),size: 30,),
                          Gap(23),
                          customText(text: "Logout",textsize: 16,fontweight: FontWeight.w400,color:Color(0xFFF76969) ,)
                        ],),
                      ),
                    ),

                  ],
                )
              ],
            ),
          )),
          isLogout == true ?ShowLogoutDialog(ontap: (){
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => Loginview()),(Route<dynamic> route) => false,);
          },cancel: (){
            Navigator.pop(context);
            setState(() {
              isLogout = false;
            });
          },):customText(text: ""),
        ],
      ),
    );
  }
}
