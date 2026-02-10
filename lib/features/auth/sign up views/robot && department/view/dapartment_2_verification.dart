import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/widget/List.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/widget/bar.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/widget/check.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class Dapartment2Verification extends StatefulWidget {
  const Dapartment2Verification({super.key});

  @override
  State<Dapartment2Verification> createState() => _Dapartment2VerificationState();
}

class _Dapartment2VerificationState extends State<Dapartment2Verification> {
  bool ischecked = false ;
  bool minus = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF060B1B),
        child: Column(
        children: [
          Gap(60),

          /// head
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Icon(CupertinoIcons.back , color: Colors.white,size: 35,)
                ),
                Gap(20.5),
                customText(text: "Sales Tables",color: Colors.white,fontweight: FontWeight.w400,textsize: 26,)
              ],
            ),
          ),

          /// bar
          Bar(),


          ///check
          Gap(41),
        Check(ischecked: ischecked),
          
          
          /// list
         Column(
           children: List.generate(5, (index) =>  Listwid(),),
         )
        ],
      ),)
    );
  }
}
