import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class Check extends StatefulWidget {
   Check({super.key , required this.ischecked});
bool ischecked ;
  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:24.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                widget.ischecked = !widget.ischecked ;
              });
            },
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: widget.ischecked == true ? Colors.redAccent:Color(0xFFE1F4FF),
                  border: Border.all(
                      color: Color(0xFFE1F4FF),
                      width: 3
                  )
              ),
            ),
          ),
          Gap(8),
          customText(text: "Select All",color: Colors.white,textsize: 16,fontweight: FontWeight.w400,)
        ],
      ),
    );
  }
}
