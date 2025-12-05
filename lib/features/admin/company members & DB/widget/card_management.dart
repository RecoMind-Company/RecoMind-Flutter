import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/custom_text.dart';



class CardManagement extends StatefulWidget {
  const CardManagement({super.key,required this.gmail_copy,required this.Name});
  final String gmail_copy ;
  final String Name;
  @override
  State<CardManagement> createState() => _CardManagementState();
}

class _CardManagementState extends State<CardManagement> {
  bool tap = false;


  // دالة نسخ البريد الإلكتروني
  void _copyEmail(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.gmail_copy)).then((_) {
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
    return Column(children: [
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SizeTransition(
            sizeFactor: animation,
            axis: Axis.vertical,
            child: child,
          );
        },


        child: tap != true
            ? Container(
          key: const ValueKey<bool>(false), // مفتاح خاص بالحالة المدمجة
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          height: 60,
          width:  double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF212635),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/Home/Ellipse 79.png"),
            ),
            const Gap(8),
            customText(
              text: widget.Name,
              fontweight: FontWeight.w400,
              textsize: 18,
              color: const Color(0xFFFFFFFF),
            ),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  setState(() {
                    tap = !tap;
                  });
                },
                child: Container(
                  width: 15,
                    height: 15,
                    child: SvgPicture.asset("assets/down.svg")))
          ]),
        )

            : Container(
          key: const ValueKey<bool>(true),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF212635),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/Home/Ellipse 79.png"),
                ),
                const Gap(8),
                customText(
                  text: widget.Name,
                  fontweight: FontWeight.w400,
                  textsize: 18,
                  color: const Color(0xFFFFFFFF),
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        tap = !tap;
                      });
                    },
                    child: Container(
                        width: 15,
                        height: 15,
                        child: SvgPicture.asset("assets/Team_Leader/up.svg")))
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
                    text: widget.gmail_copy,
                    color: CupertinoColors.inactiveGray,
                  )
                ],
              ),
              const Gap(20),
              // تم تعديل onTap لاستخدام الدالة المنفصلة
              button(
                  onPressed: () => _copyEmail(context),
                  color: const Color(0xFF212635),
                  borderColor: AppColor.primaryColor,
                  buttonText: "Copy Email",
                  textColor: Colors.white)
            ],
          ),
        ),
      ),
    ],);
  }
}
