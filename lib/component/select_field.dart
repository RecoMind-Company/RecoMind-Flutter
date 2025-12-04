import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class selectField extends StatefulWidget {
  selectField(
      {super.key,
      required this.icon,
      required this.options,
      required this.label});

  IconData? icon;
  List<String> options = [];
  String? label;

  @override
  State<selectField> createState() => _selectFieldState();
}

class _selectFieldState extends State<selectField> {
  String? selectedOption;
  bool isclicked=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16, left: 7),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Icon(
                widget.icon,
                color: Colors.white,
              )),
          Expanded(
            flex: 6,
            child: DropdownButtonFormField<String>(
              value: selectedOption,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              hint: Text(
                widget.label!,
                style:
                    TextStyle(color: Color(0xFFB8ADAD), fontFamily: "Poppins"),
              ),
              dropdownColor: Color(0xFF060B1B),
              style: TextStyle(color: Colors.white),
              icon: isclicked==true ?Icon(
                FeatherIcons.chevronDown,
                size: 35,
                color: Colors.white,
              ):Icon(
                FeatherIcons.chevronUp,
                size: 35,
                color: Colors.white,
              ),
              items: widget.options
                  .map((option) =>
                      DropdownMenuItem(value: option, child: Text(option)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
