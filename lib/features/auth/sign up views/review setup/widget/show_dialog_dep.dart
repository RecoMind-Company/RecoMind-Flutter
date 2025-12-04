import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../shared/widgets/button.dart';
import '../../../../../shared/widgets/textfiekd.dart';
import '../../../../../shared/widgets/title_Text_Field.dart';
import '../../company setup/widgets/dropDown.dart';


class ShowDialogComDep extends StatefulWidget {
  ShowDialogComDep({super.key,required this.ontap,required this.list});
  Function() ontap;
  late List list;
  @override
  State<ShowDialogComDep> createState() => _ShowDialogComDepState();
}

class _ShowDialogComDepState extends State<ShowDialogComDep> {
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
            Gap(200),
            Expanded(
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
                  Gap(29),
                  Container(
                    width: 154,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap:widget.ontap,
                        child: Icon(
                          CupertinoIcons.xmark,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(8)
                    ],
                  ),
                  Gap(24),
                  Row(children: [
                Row(
                children: [
                Padding(
                padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    width: 270,
                    child: SizedBox(
                      height: 48,
                      child: TextField(
                          decoration: InputDecoration(
                              hintText: "Enter Department Name ",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide:
                                  BorderSide(color: Colors.grey)),
                              prefixIcon: Icon(Icons.account_tree),
                              prefixIconColor: Color(0xFFEEEEEE))),
                    ),
                  )
              ),
              SizedBox(
                height: 48,
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 20,
                  height: 53,
                  color: Color(0xFF88E0FF),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        fontWeight: FontWeight.bold,
                      ),
                      Text(
                        "Add",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
              )
              ],
            )
                  ],),
                  Gap(16),
                  Column(children: List.generate(widget.list.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 37,
                        decoration: BoxDecoration(
                          color: Color(0xFF2B313E),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText(text: widget.list[index] , fontweight: FontWeight.w400, textsize: 16, color: Colors.white),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color:Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Color(0xFF2B313E),
                                size: 16,
                              ),

                            )
                          ]
                        )
                      ),
                    );
                  },),),
                  Gap(32),
                  button(onPressed: (){}, color: AppColor.primaryColor, borderColor: AppColor.primaryColor, buttonText: "Save", textColor: Colors.black)
                  ,Gap(25)

                ],)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
