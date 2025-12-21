import 'package:flutter/material.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/data/team_Model.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class Department extends StatefulWidget {
   Department({super.key, required this.depList,this.isclicked});
 List<TeamNameModel>? depList;
 bool? isclicked;


  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  @override
  Widget build(BuildContext context) {
    int lenth ;
    if(widget.isclicked == true){
      if(widget.depList == null && widget.depList!.isEmpty){
        lenth = 3;
      }else{
        lenth = widget.depList!.length;
      }
    }else{
      lenth = 3;
    }
    if(widget.depList!.length < 3){
      lenth = widget.depList!.length;
    }

    return  Column(children: List.generate(lenth, (index) {
      final String name = widget.depList!.isNotEmpty
          ? widget.depList![index].name
          : "Sales";
      return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xFF454A5599),
            ),
            child: customText(text: name,textsize: 16,fontweight: FontWeight.w400,color: Color(0xFFFFFFFF),),
          ),
        );} ,))
    ;
  }
}
