import 'package:flutter/material.dart';

class DiverWid extends StatelessWidget {
  const DiverWid({super.key,required this.width});
final double width;
  @override
  Widget build(BuildContext context) {
    return Container(width: width,
      child: Divider(
        color:Color(0xFF7F7F7F),
        thickness: 1,
      ),
    );
  }
}
