import 'package:flutter/material.dart';
import 'package:recomind/features/auth/log%20in%20views/log%20in/view/log_in.dart';
import 'package:recomind/features/auth/sign%20up%20views/sign%20up/views/sign_Up.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';

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
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                child: const Text(
                  """RecoMind helps your company turn data into insights and insights into action""",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      height: 1.5,
                      fontFamily: "Poppins"),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'all powered by AI',
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "Poppins"),
              ),
              const SizedBox(height: 60),
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
              const SizedBox(height: 15),
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
