import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../shared/widgets/button.dart';
import '../../../../../shared/widgets/textfiekd.dart';
import '../../../../../shared/widgets/title_Text_Field.dart';

class ShowLogoutDialog extends StatefulWidget {
  ShowLogoutDialog({super.key,required this.ontap,required this.cancel});
final Function() ontap , cancel;

  @override
  State<ShowLogoutDialog> createState() => _ShowDialogComDepState();
}

class _ShowDialogComDepState extends State<ShowLogoutDialog> {
  final ValueNotifier<String?> _selectedCountryNotifier =
  ValueNotifier<String?>("EGYPT");

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.transparent.withOpacity(0.2),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 300.0,horizontal: 20),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 23),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF060B1B),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(children: [
                    Gap(11),
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [GestureDetector(onTap: widget.cancel,child: Icon(Icons.cancel_outlined,color: Color(0xFFF76969)))],),
                    Gap(25),
                    customText(text: "Are you sure you want to log out?",color: Colors.white,textsize: 18,fontweight: FontWeight.w700,),
                    Gap(8),
                    customText(text: "If you confirm, you will be logged\nout from this device.",textsize: 14,fontweight: FontWeight.w500,iscenter: true,color: Colors.white,),
                    Gap(16),
                    Divider(
                      color: Color(0xFF434A57),
                      thickness: 1,),
                   GestureDetector(
                     onTap: widget.ontap,
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        height: 44,
                        width: 317,
                        child: customText(text: "Log Out",color:Color(0xFFF76969) ,fontweight: FontWeight.w600,textsize: 20,),
                      ),
                   ),
                    Gap(5),

                  ],)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
