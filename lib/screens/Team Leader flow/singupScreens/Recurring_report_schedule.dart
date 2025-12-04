import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/component/select_field.dart';
import 'package:recomind/screens/Team%20Leader%20flow/component_widget/bar.dart';
import 'package:recomind/screens/Team%20Leader%20flow/component_widget/title.dart';
import 'package:recomind/screens/Team%20Leader%20flow/singupScreens/upload_teamLeader_doc.dart';

class scheduleReport extends StatefulWidget {
  const scheduleReport({super.key});

  @override
  State<scheduleReport> createState() => _scheduleReportState();
}

class _scheduleReportState extends State<scheduleReport> {
  List<String> optionslist = ["daily", "weekly", 'monthly'];
  String? selectedOption;
  bool isclicked = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: titleRecurring(texttitle: "Recurring Report Setup",),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Bar(color: Color(0xFF7EE3FF)),
                SizedBox(
                  width: 8,
                ),
                Bar(color: Color(0xFF7EE3FF)),
                SizedBox(
                  width: 8,
                ),
                Bar(color: Color(0xffEFEFEF)),
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
                "Set your report schedule",
                style: TextStyle(
                    color: Color(0xffF2E8E8),
                    fontSize: 20,
                    fontFamily: "Poppins"),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34.0),
              child: selectField(
                icon: Icons.date_range,
                options: optionslist,
                label: "e.g. Daily, Weekly, Monthly",
              ),
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
                        builder: (context) => uploadTeamLeader(),
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
