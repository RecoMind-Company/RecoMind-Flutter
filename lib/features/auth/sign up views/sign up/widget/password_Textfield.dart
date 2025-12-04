import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/title_Text_Field.dart';

class PasswordTextfield extends StatelessWidget {
  PasswordTextfield({super.key,required this.passwordController});
  final TextEditingController? passwordController ;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TitleTextField(text: "Password"),
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFF060B1B),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffEFEFEF)),
        ),
        child: TextField(
          controller: passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock_outline,
                color: Colors.white54),
            hintText: "Enter Password",
            hintStyle: TextStyle(
                color: Color(0xFFB8ADAD),
                fontFamily: "Poppins"),
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.symmetric(vertical: 18),
          ),
        ),
      ),
    ],);
  }
}
