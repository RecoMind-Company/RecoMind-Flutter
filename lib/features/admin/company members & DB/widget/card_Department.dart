import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class CardDepartment extends StatefulWidget {
  const CardDepartment(
      {super.key,
      required this.ontap,
      required this.Name,
      required this.number});

  final Function() ontap;
  final String Name;
  final String number;

  @override
  State<CardDepartment> createState() => _CardDepartmentState();
}

class _CardDepartmentState extends State<CardDepartment> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        key: const ValueKey<bool>(false),
        // مفتاح خاص بالحالة المدمجة
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        height: 60,
        width: 346,
        decoration: BoxDecoration(
          color: const Color(0xFF212635),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          SvgPicture.asset(
            "assets/Home/SVG_Icon/markting.svg",
            height: 30,
            width: 30,
          ),
          const Gap(8),
          customText(
            text: widget.Name,
            fontweight: FontWeight.w400,
            textsize: 18,
            color: const Color(0xFFFFFFFF),
          ),
          const Spacer(),
          Container(
              width: 53,
              height: 29,
              decoration: BoxDecoration(
                color: const Color(0xFF293747),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customText(
                    text: "${widget.number}",
                    fontweight: FontWeight.w400,
                    textsize: 14,
                    color: Colors.white,
                  ),
                  Gap(4),
                  SvgPicture.asset("assets/Team_Leader/number_member.svg"),
                ],
              )),
          Gap(12),
          Container(
              width: 25,
              height: 25,
              child: SvgPicture.asset("assets/Team_Leader/right.svg"))
        ]),
      ),
    );
  }
}
