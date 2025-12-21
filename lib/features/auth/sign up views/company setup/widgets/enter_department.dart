import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';

class EnterDepartment extends StatefulWidget {
  EnterDepartment(
      {super.key,
      this.isLoading,
      required this.onTap,
      required this.Controller});

  bool? isLoading;

  Function() onTap;
  TextEditingController Controller;

  @override
  State<EnterDepartment> createState() => _EnterDepartmentState();
}

class _EnterDepartmentState extends State<EnterDepartment> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 280,
              child: SizedBox(
                height: 48,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                    controller: widget.Controller,
                    decoration: InputDecoration(
                        hintText: "Enter Department Name ",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.grey)),
                        prefixIcon: Icon(Icons.account_tree),
                        prefixIconColor: Color(0xFFEEEEEE))),
              ),
            )),
        SizedBox(
          height: 48,
          child: MaterialButton(
            onPressed: widget.onTap,
            minWidth: 20,
            height: 53,
            color: Color(0xFF88E0FF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                widget.isLoading == true
                    ? CupertinoActivityIndicator(
                        color: AppColor.darkBlue,
                         radius: 12,
                      )
                    : Icon(
                        Icons.add,
                        fontWeight: FontWeight.bold,
                      ),
                Text(
                  "Add",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        )
      ],
    );
  }
}
