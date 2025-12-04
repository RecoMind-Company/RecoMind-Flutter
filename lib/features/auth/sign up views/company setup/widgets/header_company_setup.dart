import 'package:flutter/material.dart';
import 'package:recomind/core/constants/app_colors.dart';


class HeaderCompanySetup extends StatelessWidget {
  const HeaderCompanySetup({super.key,required this.pageNumber});
  final int pageNumber ;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        return Container(height: 5,width: 65,color: pageNumber == index ? Colors.white : pageNumber>index?AppColor.primaryColor:Colors.grey.shade600);
      },),);
  }
}
