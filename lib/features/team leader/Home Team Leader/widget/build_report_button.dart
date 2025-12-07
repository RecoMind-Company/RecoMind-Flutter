import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class BuildReportButton extends StatelessWidget {
  const BuildReportButton({super.key, required this.onTap});
final Function() onTap ;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 44,
          width: 370,
          decoration: BoxDecoration(
            color: const Color(0xFF7EE3FF),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.5),
                blurRadius: 11,
                spreadRadius: 0.5,
              ),
            ],
          ),
          child: const customText(
            text: "Build My Report",
            textsize: 16,
            fontweight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
