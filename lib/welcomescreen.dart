import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/auth/log%20in%20views/log%20in/view/log_in.dart';
import 'package:recomind/features/auth/sign%20up%20views/sign%20up/views/sign_Up.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/welcome.png',
                height: 272,
              ),
              Gap(40),
              Container(
                width: double.infinity,
                child: const customText(
                 text: """RecoMind helps your company turn data into insights and insights into action""",
                  iscenter: true,
                    color: Colors.white70,
                      textsize: 20,
                      ),

              ),
              Gap(10),
              const customText(
                text: 'all powered by AI',
                    color: Colors.lightBlueAccent,
                    fontweight: FontWeight.bold,
                    textsize: 16,
                    ),
             Gap(60),
              //=========sinup button=========
              button(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUP()));
                  print("object");
                },
                color: Color(0xFF88E0FF),
                borderColor: Color(0xFF88E0FF),
                buttonText: "Sign Up",
                textColor: Colors.black,
              ),
              Gap(15),
              //=========login button=========
              button(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return Loginview();
                  },));
                },
                color: Color(0xff060B1B),
                borderColor: Color(0xFF88E0FF),
                buttonText: "Log In",
                textColor:Color(0xFF88E0FF) ,
              )
            ],
          ),
        ),
      ),
    );
  }
}
