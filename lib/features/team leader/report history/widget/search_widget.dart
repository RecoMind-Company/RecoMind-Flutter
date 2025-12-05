import 'package:flutter/material.dart';
import 'package:recomind/core/constants/app_colors.dart';


class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF1E2029),
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.date_range,color: AppColor.primaryColor,),
          fillColor:Color(0xFF1E2029),
          filled: true,
          hintText: "Enter report date",
          hintStyle: TextStyle(
            color: Color(0xFFB5B5B5),
            fontSize: 14
          ),
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Color(0xFFB5B5B5),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color(0xFF1E2029)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color(0xFF1E2029)),
          ),
        ),
      ),
    );
  }
}
