import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/screens/Admin/Home/Home_page.dart';

class completesetup extends StatefulWidget {
  const completesetup({super.key, required this.navigatscreen});

  final Widget? navigatscreen;

  @override
  State<completesetup> createState() => _completesetupState();
}

class _completesetupState extends State<completesetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Containerwid(
      child: Column(
        children: [
          SizedBox(
            height: 73,
          ),
          Container(
              child: Text(
            "Setup Complete!",
            style: TextStyle(
                fontSize: 28,
                color: Color(0xffEEEEEE),
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 40,
          ),
          Image(image: AssetImage("assets/complete.png")),
          SizedBox(
            height: 40,
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                "Let’s make your company thrive!",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xffEEEEEE),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 40,
          ),
          MaterialButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => widget.navigatscreen!));
              },
              child: Container(
                  width: 330,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff070C1E),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700),
                  )),
              color: Color(0xFF7EE3FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ))
        ],
      ),
    ));
  }
}
