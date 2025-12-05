import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';



class ChatbotSetting extends StatelessWidget {
  const ChatbotSetting({super.key,required this.cancel});
final Function() cancel ;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            alignment:Alignment.centerRight,
        height: double.infinity,
        width: double.infinity,
        color: Colors.black.withOpacity(0.3),
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 28),
          width: 243,
          height: double.infinity,
          color: AppColor.darkBlue,
          child: Column(
            children: [
              Gap(83),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                    },
                    child:Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Icon(Icons.edit,color: AppColor.darkBlue,),
                        Gap(2),
                        customText(text: "New Chat",fontweight: FontWeight.w400,textsize: 14,color: AppColor.darkBlue,)

                      ],),
                    )

                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: cancel,
                    child:Icon(CupertinoIcons.xmark,color: Colors.white,size: 30,)

                  )
                ],
              ),
              Gap(32),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search,size: 25,),
                  suffixIconColor: Colors.white.withOpacity(0.5),
                  hintText: "Search",
                  hintStyle: const TextStyle(
                      color: Color(0xFFB8ADAD), fontFamily: "Poppins" , fontSize: 14),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primaryColor,width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(color:AppColor.primaryColor,width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),

                ),
              ),
              Gap(32),



            ],
          ),
        ) ,
      ),
    ),
    );
  }
}
