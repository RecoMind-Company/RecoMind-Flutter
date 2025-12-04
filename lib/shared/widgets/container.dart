import 'package:flutter/material.dart';


class Containerwid extends StatelessWidget {
   Containerwid({super.key ,required this.child});
dynamic child ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0077A8),
              Color(0xFF003B57),
              Color(0xFF060B1B),
            ],
            stops: [
              0.0001,
              0.02,
              0.20
            ]),
      ),
      child: child
    );
  }
}
