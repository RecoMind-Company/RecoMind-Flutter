import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recomind/screens/Team%20Leader%20flow/component_widget/bar.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/screens/Team%20Leader%20flow/component_widget/title.dart';
import 'package:recomind/screens/Team%20Leader%20flow/singupScreens/choice_report_focus.dart';

class recurringReportSetup extends StatefulWidget {
  recurringReportSetup({super.key});

  @override
  State<recurringReportSetup> createState() => _recurringReportSetupState();
}

class _recurringReportSetupState extends State<recurringReportSetup> {
  bool? clickedPremium = false;
  bool? clicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
          child: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          titleRecurring(
            texttitle: "Recurring Reports Setup",
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Bar(color: Color(0xffEFEFEF)),
              SizedBox(
                width: 8,
              ),
              Bar(color: Color(0xff585B65)),
              SizedBox(
                width: 8,
              ),
              Bar(color: Color(0xff585B65)),
              SizedBox(
                width: 8,
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsetsGeometry.only(left: 35),
            child: Text(
              "Choose report content",
              style: TextStyle(color: Color(0xffF2E8E8), fontSize: 24),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            height: 29,
            width: 349,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: AlignmentGeometry.centerLeft,
                    end: AlignmentGeometry.centerRight,
                    colors: [
                      Color(0xff152B46),
                      Color(0xff22446A),
                    ]),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: AssetImage("assets/star.png"),
                ),
                Text(
                  "You’re on Premium plan enjoy all report types",
                  style: TextStyle(
                      fontSize: 13, fontFamily: "Poppins", color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(
            height: 32,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                clickedPremium = !clickedPremium!;
                clicked = false;
              });
            },
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: clickedPremium == true ? 240 : 230,
                  // انيميشن في الحجم
                  width: clickedPremium == true ? 355 : 345,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      border: Border.all(
                        color: clickedPremium == true
                            ? Color(0xFF7EE3FF)
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: clickedPremium == true
                          ? [
                              BoxShadow(
                                color: Color(0xFF7EE3FF).withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ]
                          : []),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(21),
                    child: Image.asset(
                      "assets/Team_Leader/prime.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 220,
                    width: 340,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/Team_Leader/Group 203 (1).png"),
                        SizedBox(height: 12),
                        AnimatedDefaultTextStyle(
                          duration: Duration(milliseconds: 300),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: clickedPremium == true ? 22 : 18,
                            fontWeight: FontWeight.w500,
                          ),
                          child: Text("Insights & Plan"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                clicked = !clicked!;
                clickedPremium = false;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: Alignment.center,
              height: clicked == true ? 240 : 230,
              // انيميشن في الحجم
              width: clicked == true ? 355 : 345,
              // انيميشن في الحجم
              decoration: BoxDecoration(
                  color:
                      clicked != true ? Color(0xFF1F212E) : Color(0xFF272834),
                  borderRadius: BorderRadius.circular(21),
                  border: Border.all(
                    color: clicked != true
                        ? Colors.transparent
                        : Color(0xFF7EE3FF),
                    width: clicked == true ? 3 : 1, // انيميشن في سمك البوردر
                  ),
                  boxShadow: clicked == true
                      ? [
                          BoxShadow(
                            color: Color(0xFF7EE3FF).withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ]
                      : []),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/Team_Leader/Group.png")),
                  SizedBox(height: 12),
                  AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: clicked == true ? 22 : 18,
                      fontWeight: FontWeight.w500,
                    ),
                    child: Text("Insights Only"),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: button(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => choiceReportSetup(),
                      ));
                },
                color: Color(0xFF7EE3FF),
                borderColor: Color(0xFF7EE3FF),
                buttonText: "Continue",
                textColor: Colors.black),
          )
        ],
      )),
    );
  }
}
