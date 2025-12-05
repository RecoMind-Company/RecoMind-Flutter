import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class UploadButton2 extends StatelessWidget {
  const UploadButton2({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
              color: Color(0xFF454A5566),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file,
                    color: Color(0xFFEEEEEE),
                  ),
                  Gap(5),
                  customText(
                    text: "Upload Excel file",
                    color: Color(0xFFEEEEEE),
                    textsize: 14,
                    fontweight: FontWeight.w400,
                  )
                ],
              ),
              customText(
                text: "Upload an Excel file to add all Team Leaders at once",
                color: Color(0xFFAFAFAF),
                fontweight: FontWeight.w400,
                textsize: 10,
              )
            ],
          ),
        ));
  }
}
