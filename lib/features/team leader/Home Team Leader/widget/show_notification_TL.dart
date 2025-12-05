import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class ShowNotificationTl extends StatelessWidget {
  const ShowNotificationTl({super.key, required this.cancel});
final Function() cancel;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 28.0, vertical: 150),
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Color(0xFF060B1B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// X icon
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: cancel,
                    child: Icon(
                      CupertinoIcons.xmark,
                      color: CupertinoColors.inactiveGray,
                    ),
                  )
                ],
              ),
              Gap(25),
              Column(
                children: List.generate(9, (index) => Column(
                  children: [
                    customText(
                      text:
                      "Here are the latest updates related to your account and company.",
                      color: Colors.white,
                      fontweight: FontWeight.w500,
                      textsize: 12,
                    ),
                    Gap(17),
                    Divider(
                      thickness: 1,
                      color: Color(0xFF285863),
                    ),
                    Gap(17),

                  ],
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
