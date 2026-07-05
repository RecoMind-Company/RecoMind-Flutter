import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recomind/features/auth/sign%20up%20views/plan%20&%20complete/widget/star.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class Card_pr extends StatelessWidget {
  // أضفنا هذه المتغيرات للتحكم في الحالة
  final bool isSelected;
  final VoidCallback onTap;

  Card_pr({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.price,
    required this.title,
    required this.cam_1,
    required this.cam_2,
    required this.cam_3,
    required this.cam_4,
    this.cam5 = "",
  });

  String price, title, cam_1, cam_2, cam_3, cam_4, cam5;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.orange : Colors.transparent, // لون الحدود عند التفعيل
              width: 2,
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Image(
                  image: AssetImage("assets/Team_Leader/premium_card.png"),
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 25),
                  child: customText(
                      text: price,
                      color: Color(0xffEEEEEE),
                      textsize: 18,
                      fontweight: FontWeight.bold),
                ),
                Positioned(
                  right: 35,
                  top: 25,
                  child: customText(
                      text: title,
                      color: Color(0xffEEEEEE),
                      textsize: 16,
                      fontweight: FontWeight.bold),
                ),
                Positioned( child: Star(text: cam_1)),
                Positioned(top: 30, child: Star(text: cam_2)),
                Positioned(top: 60, child: Star(text: cam_3)),
                Positioned(top: 90, child: Star(text: cam_4)),
                cam5 == ""
                    ? Container()
                    : Positioned(top: 120, child: Star(text: cam5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}