import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/component/select_field.dart';
import 'package:recomind/screens/Team%20Leader%20flow/singupScreens/Recurring_report_setup.dart';

class selectDepartment extends StatefulWidget {
  selectDepartment({super.key});

  @override
  State<selectDepartment> createState() => _selectDepartmentState();
}

class _selectDepartmentState extends State<selectDepartment> {
  final List<String> optionsList = [
    'Marketing',
    'Technology',
    'Finance',
    'Education'
  ];

  String? selectedOption;

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
            "Select Your Departments",
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                selectField(label:"Select your department" ,icon:Icons.group ,options:optionsList ,),
                SizedBox(
                  height: 32,
                ),
                button(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => recurringReportSetup(),
                          ));
                    },
                    color: Color(0xFF7EE3FF),
                    borderColor: Color(0xFF7EE3FF),
                    buttonText: "Continue",
                    textColor: Colors.black)
              ],
            ),
          ),
        ],
      )),
    );
  }
}
