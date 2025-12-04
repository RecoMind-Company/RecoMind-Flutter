import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';

class report extends StatefulWidget {
  const report(
      {super.key,
      required this.naigatScreen,
      required this.title,
      required this.subtitle,
      required this.buttontext});

  final Widget naigatScreen;
  final String title;
  final String subtitle;
  final String buttontext;

  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              "${widget.title}",
              style: TextStyle(fontSize: 32, color: Colors.white70),
            ),
            SizedBox(height: 40),
            Image.asset("assets/report.png"),
            SizedBox(
              height: 40,
            ),
            Text(
              "${widget.subtitle}",
              style: TextStyle(fontSize: 29, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                  width: double.infinity,
                  child: button(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => widget.naigatScreen,
                          ));
                    },
                    color: const Color(0xFF88E0FF),
                    borderColor: const Color(0xFF88E0FF),
                    buttonText: "Continue",
                    textColor: Colors.black,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
