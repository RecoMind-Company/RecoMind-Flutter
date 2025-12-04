import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class PasswordRules extends StatelessWidget {
  const PasswordRules({super.key,required this.passwordController,required this.isPasswordValid});
  final TextEditingController passwordController;
  final bool isPasswordValid ;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: passwordController.text.isNotEmpty
              ? Row(
            children: [
              Icon(
                isPasswordValid
                    ? Icons.check_circle
                    : Icons.error,
                color: isPasswordValid
                    ? Colors.greenAccent
                    : Colors.redAccent,
                size: 18,
              ),
              Gap(6),
              isPasswordValid ? customText(text: "Your password meets all requirements" , color:  Colors.greenAccent,textsize: 12,):
                  customText(text: "Password must be at least 8 characters" , textsize: 12 ,color:Colors.redAccent ,)
            ],
          )
              : const SizedBox.shrink(),
        ),
        Row(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(bottom: 20.0),
              child: Icon(
                Icons.error,
                color: Colors.grey,
                size: 14,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
                child: Text(
                  textScaler:TextScaler.linear(1.0),
                  "Password must be at least 8 characters , Password must be at least 8 characters ",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: "Poppins"),
                  softWrap: true,
                  maxLines: null,
                ))
          ],
        )
      ],
    );
  }
}
