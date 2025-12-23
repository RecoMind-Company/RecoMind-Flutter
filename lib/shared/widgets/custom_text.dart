import 'package:flutter/material.dart';

class customText extends StatelessWidget {
  const customText({
    super.key,
    required this.text,
    this.textsize,
    this.fontweight,
    this.color,
    this.isunderline,
    this.iscenter,
  });

  final String text;
  final double? textsize;
  final FontWeight? fontweight;
  final Color? color;
  final bool? isunderline;
  final bool? iscenter;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textsize,
        fontWeight: fontweight,
        color: color,
        decoration:
        isunderline == true ? TextDecoration.underline : TextDecoration.none,
        decorationColor: color,
        fontFamily: "Poppins",
      ),
      textAlign: iscenter == true ? TextAlign.center : TextAlign.start,
      softWrap: true,
      overflow: TextOverflow.visible, // يظهر كل النص بدون قطع
    );
  }
}
