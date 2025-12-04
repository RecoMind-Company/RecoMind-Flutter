import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class MembersCards extends StatelessWidget {
   MembersCards({super.key});
  final List Members = [
    "Noreen motaz",
    "Noreen motaz",
    "Noreen motaz",
    "Noreen motaz",
    "Noreen motaz",
    "Noreen motaz",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        Members.length,
            (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 8),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF454A55).withOpacity(0.40),
                borderRadius: BorderRadius.only(
                    topLeft: 0 == index
                        ? Radius.circular(12)
                        : Radius.circular(0),
                    topRight: 0 == index
                        ? Radius.circular(12)
                        : Radius.circular(0),
                    bottomLeft: index+1 == Members.length
                        ? Radius.circular(12)
                        : Radius.circular(0),
                    bottomRight: index+1 == Members.length
                        ? Radius.circular(12)
                        : Radius.circular(0)),
              ),
              child: Row(
                children: [
                  CircleAvatar(radius: 20,backgroundImage: AssetImage("assets/Home/Ellipse 79.png"),),
                  Gap(8),
                  customText(text: Members[index],fontweight: FontWeight.w500,textsize: 16,color: Colors.white,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
