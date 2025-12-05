import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool isLightMode = false;
  bool isNotificationsOn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF060B1B),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Gap(70),
              Row(
                children: [
                  Gap(5),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                        size: 35,
                      )),
                  Gap(85),
                  customText(
                    text: "Settings",
                    color: Colors.white,
                    fontweight: FontWeight.w400,
                    textsize: 28,
                  )
                ],
              ),
              Gap(39),

              ///light mode
              Row(
                children: [
                  Icon(CupertinoIcons.sun_max,color: Colors.white,size: 25,),
                  Gap(10),
                  customText(text: "Light Mode",color: Colors.white,textsize: 16,fontweight: FontWeight.w500,),
                  Spacer(),
                  Switch(activeColor: AppColor.primaryColor,
                    value: isLightMode, onChanged: (value) {
                    setState(() {
                      isLightMode = value;
                    });
                  },)
                ],
              ),

              ///diver
              Gap(32),
              Divider(
                color: Color(0xFF498495),
                thickness: 1,),
              Gap(32),

              /// notification
              Row(
                children: [
                  Icon(Icons.notifications_none_rounded,color: Colors.white,size: 25,),
                  Gap(10),
                  customText(text: "Notifications",color: Colors.white,textsize: 16,fontweight: FontWeight.w500,),
                  Spacer(),
                  Switch(activeColor: AppColor.primaryColor,
                    value: isNotificationsOn, onChanged: (value) {
                      setState(() {
                        isNotificationsOn = value;
                      });
                    },)
                ],
              ),

              ///diver
              Gap(32),
              Divider(
                color: Color(0xFF498495),
                thickness: 1,),

            ]
          ),
        )
      )
    );
  }
}
