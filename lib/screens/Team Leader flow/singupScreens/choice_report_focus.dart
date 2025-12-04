import 'package:flutter/material.dart';
import 'package:recomind/component/DiverCustom.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';
import 'package:recomind/screens/Team%20Leader%20flow/component_widget/bar.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/screens/Team%20Leader%20flow/component_widget/report_focus_component.dart';
import 'package:recomind/screens/Team%20Leader%20flow/component_widget/title.dart';
import 'package:recomind/screens/Team%20Leader%20flow/singupScreens/Recurring_report_schedule.dart';

class choiceReportSetup extends StatefulWidget {
  choiceReportSetup({super.key});

  @override
  State<choiceReportSetup> createState() => _choiceReportSetupState();
}

class _choiceReportSetupState extends State<choiceReportSetup> {
  bool? overview = false;
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
            titleRecurring(texttitle: "Recurring Reports Setup",),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Bar(color: Color(0xFF7EE3FF)),
                SizedBox(
                  width: 8,
                ),
                Bar(color: Color(0xffEFEFEF)),
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
                "Choose Your Report Focus",
                style: TextStyle(
                    color: Color(0xffF2E8E8),
                    fontSize: 20,
                    fontFamily: "Poppins"),
              ),
            ),SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: textfield(hint: "Type here... (e.g. Sales growth ,...)",),
            ) , SizedBox(height: 6,),
            diverCustom(textdiver: "Or choose from the available options",diver: "ـــــــــــ",)
        ,
            SizedBox(
              height: 16,
            ),
            Confocus(
              image: "assets/Team_Leader/overview.png",
              label: "OverView",
              width: 345,
              height: 172,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Confocus(
                  image: "assets/Team_Leader/campaigns.png",
                  label: "Campains",
                  width: 164.5,
                  height: 164.5,
                ),
                SizedBox(
                  width: 16,
                ),
                Confocus(
                  image: "assets/Team_Leader/sales.png",
                  label: "Sales",
                  width: 164.5,
                  height: 164.5,
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34.0),
              child: button(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => scheduleReport(),
                      ),
                    );
                  },
                  color: Color(0xFF7EE3FF),
                  borderColor: Color(0xFF7EE3FF),
                  buttonText: "Continue",
                  textColor: Colors.black),
            ),


          ],
        ),
      ),
    );
  }
}
