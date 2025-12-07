import 'package:flutter/material.dart';


class MultiLinsTextfield extends StatelessWidget {
  const MultiLinsTextfield({super.key,required this.controller});
 final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white,fontSize: 12),
      maxLines: 5,
      decoration: InputDecoration(
        hintText: "Describe your company’s purpose, services, and goals…",
        hintStyle: const TextStyle(
            color: Color(0xFFB8ADAD), fontFamily: "Poppins" , fontSize: 12),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffEFEFEF),width: 1),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffEFEFEF),width: 1),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),

      ),
    );
  }
}
