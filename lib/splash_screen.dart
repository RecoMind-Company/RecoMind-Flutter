import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/welcomescreen.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  bool showGroup = false;
  bool showText = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showGroup = true;
      });
    });

    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        showText = true;
      });
    });

    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              SizedBox(
                height: 400,
              ),
              Stack(
                children: [
                  Positioned( top: 1.6, left: 54.5,
                    child: Center(
                      child: Image.asset(
                        "assets/Logo.png",
                        height: 80,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: showGroup ? 1.0 : 0.0,
                    duration: Duration(seconds: 2),
                    child: Center(
                      child: Image.asset(
                        "assets/Group.png",
                        height: 100,
                        width: 300,
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedOpacity(
                opacity: showText ? 1.0 : 0.0,
                duration: Duration(seconds: 2),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    "Your Business Is Our Mission",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "Poppins"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
