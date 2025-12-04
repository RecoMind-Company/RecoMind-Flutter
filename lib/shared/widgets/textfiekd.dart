import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  textfield({
    super.key,
    required this.hint,
    this.icon,
    this.controller,
    this.labeltxt,
  });

  final String hint;
  final IconData? icon;
  final TextEditingController? controller;
  String? labeltxt;

  @override
  Widget build(BuildContext context) {
    if (labeltxt != null) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "$labeltxt",
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ), SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF060B1B),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24),
          ),
          child: SizedBox(height: 52,
            child: TextField(
              controller: controller??null,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: icon == null ? null : Icon(
                    icon, color: Colors.white54),
                hintText: hint,
                hintStyle: const TextStyle(
                    color: Color(0xFFB8ADAD), fontFamily: "Poppins"),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              ),
            ),
          ),
        )
      ]);
    } else {
      return SizedBox(height: 65,
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              prefixIcon: icon == null ? null : Icon(
                  icon, color: Colors.white54),
              hintText: hint,
              hintStyle: const TextStyle(
                  color: Color(0xFFB8ADAD), fontFamily: "Poppins" , fontSize: 14),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEFEFEF),width: 1),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEFEFEF),width: 1),
                  borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),

          ),
        ),
      );
    }
  }
}
