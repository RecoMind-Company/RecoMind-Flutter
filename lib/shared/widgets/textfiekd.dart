import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textfield extends StatefulWidget {
  textfield({
    super.key,
    required this.hint,
    this.icon,
    this.controller,
    this.labeltxt,
    this.onchange,
    this.isPassword
  });

  final String hint;
  final IconData? icon;
  final TextEditingController? controller;
  String? labeltxt;
  final Function(String)? onchange;
  late final bool? isPassword;

  @override
  State<textfield> createState() => _textfieldState();
}

class _textfieldState extends State<textfield> {
  bool isclicked = false ;
  @override
  Widget build(BuildContext context) {
    if (widget.labeltxt != null) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "${widget.labeltxt}",
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ), SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF060B1B),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24),
          ),
          child: SizedBox(height: 52,
            child: TextField(
              controller: widget.controller??null,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: widget.icon == null ? null : Icon(
                    widget.icon, color: Colors.white54),
                hintText: widget.hint,
                hintStyle: const TextStyle(
                    color: Color(0xFFB8ADAD), fontFamily: "Poppins"),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              ),
            ),
          ),
        )
      ]);
    } else {
      return SizedBox(height: 65,
        child: TextField(
          obscureText: widget.isPassword == true ? isclicked==true? false:true : false,
          onChanged: widget.onchange,
          controller: widget.controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              prefixIcon: widget.icon == null ? null : Icon(
                  widget.icon, color: Colors.white54),
              hintText: widget.hint,
              hintStyle: const TextStyle(
                  color: Color(0xFFB8ADAD), fontFamily: "Poppins" , fontSize: 14),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEFEFEF),width: 1),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEFEFEF),width: 1),
                  borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            suffixIcon: widget.isPassword == true ? isclicked == false
                ? GestureDetector(
              onTap: () {
                setState(() {
                  isclicked = true;
                });
              },
              child: Icon(CupertinoIcons.eye_fill, color: Colors.white,),):
            GestureDetector(
              onTap: () {
                setState(() {
                  isclicked = false;
                });
              },
              child: Icon(CupertinoIcons.eye_slash_fill,color: Colors.white,),)
                : null,
          ),
        ),
      );
    }
  }
}
