import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/title_Text_Field.dart';

class LittleTextfield extends StatelessWidget {
  const LittleTextfield({super.key, required this.Title, required this.hint,this.controller});
  final TextEditingController? controller;

  final String? Title, hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      child: Column(
        children: [
          TitleTextField(text: Title!),
          Gap(4),
          TextField(
            style: TextStyle(color: Colors.white),
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                  color: Color(0xFFB8ADAD),
                  fontFamily: "Poppins",
                  fontSize: 14),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEEEEEE), width: 1),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEEEEEE), width: 1),
                  borderRadius: BorderRadius.circular(8)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            ),
          )
        ],
      ),
    );
  }
}
