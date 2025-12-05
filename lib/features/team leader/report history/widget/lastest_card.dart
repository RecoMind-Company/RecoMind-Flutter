import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class LastestCard extends StatelessWidget {
  const LastestCard({super.key, required this.ontapExpand});

  final Function()? ontapExpand;

  @override
  Widget build(BuildContext context) {
    return

        ///image
        Container(
      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 24),
      height: 242,
      width: double.infinity,
      decoration: BoxDecoration(
          color:Colors.transparent,
          image: DecorationImage(
              image: AssetImage("assets/Team_Leader/write_pic.png"),
              fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColor.primaryColor, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {},
              child: Container(
                  width: 44,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: AlignmentGeometry.centerRight,
                          end: AlignmentGeometry.centerLeft,
                          colors: [Color(0xFFA6ECFF), Color(0xFF50D9FF)]),
                      borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF55E0FF).withOpacity(0.7),
                        blurRadius: 8,
                        spreadRadius: 0.1,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.download,
                          color: Color(0xFF1C274C),
                        )
                      ]))),
          GestureDetector(
            onTap: ontapExpand,
            child: Container(
              height: 44,
              width: 333,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color(0xFFB9F4FF),
                    Color(0xFF55E0FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF55E0FF).withOpacity(0.7),
                    blurRadius: 10,
                    spreadRadius: 0.1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customText(
                    text: " Tap to see full report",
                    fontweight: FontWeight.w400,
                    textsize: 16,
                    color: Color(0xFF1C274C),
                  ),
                  Gap(8),
                  SvgPicture.asset("assets/Team leader svg/zoom.svg")
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
