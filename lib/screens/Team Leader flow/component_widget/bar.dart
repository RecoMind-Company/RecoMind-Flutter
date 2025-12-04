import 'package:flutter/material.dart';


class Bar extends StatelessWidget {
  const Bar({super.key,required this.color});
final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(height: 5,
      width: 113,color: color,);
  }
}
