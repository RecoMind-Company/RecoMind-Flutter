import 'package:flutter/material.dart';



class diverCustom extends StatelessWidget {
  diverCustom({super.key , required this.textdiver,required this.diver});
final String? textdiver;
final String? diver;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(diver!,
              style: TextStyle(color: Color(0xffF2E8E8))),
        ),
        Text(
          "$textdiver!",
          style: const TextStyle(
              color: Color(0xffF2E8E8),
              fontFamily: "Poppins"),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(diver!,
              style: TextStyle(color: Color(0xffF2E8E8))),
        ),
      ],
    );
  }
}
