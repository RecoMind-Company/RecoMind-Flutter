import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class Listwid extends StatefulWidget {
  const Listwid({super.key});

  @override
  State<Listwid> createState() => _ListwidState();
}

class _ListwidState extends State<Listwid> {
  bool minus = false ;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Gap(12.5),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
          width: double.infinity,
          height: 95,
          decoration: BoxDecoration(
              color: Color(0xFF2B313E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color:minus == true ? Colors.redAccent: Color(0xFF2B313E),
                  width: 1
              )
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(text: "Sales Tables" , fontweight: FontWeight.w400,textsize: 18,color: Colors.white,),
                  customText(text: "Table Description" , fontweight: FontWeight.w500,textsize: 8,color: Color(0xFFACACAC),),
                  customText(text: """Sales Tables sales tables sales tables Sales Table sales 
tables sales tables Sales Sales Tables sales tables sales""",textsize: 10,fontweight: FontWeight.w500,color: Color(0xFFE4E4E4),)
                ],
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    minus = !minus ;
                  });
                },
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                      color: Color(0xFFE1F4FF),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color:minus == true ? Colors.redAccent:  Color(0xFFE1F4FF),
                          width:0.5
                      )
                  ),
                  child: Icon(CupertinoIcons.minus,color:minus == true ? Colors.redAccent:  Color(0xFFE1F4FF),size: 18,),
                ),
              )
            ],
          ),
        ),
      )
    ],);
  }
}
