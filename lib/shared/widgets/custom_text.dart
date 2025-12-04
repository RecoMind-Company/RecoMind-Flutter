import 'package:flutter/material.dart';

class customText extends StatefulWidget {
  const customText({
    super.key,
    required this.text,
     this.textsize,
     this.fontweight,
     this.color,
     this.isunderline,
    this.iscenter
  });

  final String text;
  final double? textsize;
  final FontWeight? fontweight;
  final Color? color;
  final bool? isunderline ;
  final bool? iscenter;
  @override
  State<customText> createState() => _customTextState();
}

class _customTextState extends State<customText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      textScaler:TextScaler.linear(1.0),
      widget.text,
      style: TextStyle(
        fontSize: widget.textsize,
        fontWeight: widget.fontweight,
        color: widget.color,
        decoration: widget.isunderline == true ? TextDecoration.underline:TextDecoration.none,
        decorationColor: widget.color,
        fontFamily: "Poppins",
      ),
      textAlign: widget.iscenter==true ? TextAlign.center : TextAlign.start,
    );
  }
}
