import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
              color: Color(0xFF454A5566),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload_file,color:Color(0xFFEEEEEE) ,),
              Gap(5),
              customText(
                text: "Upload file (PDF, DOCX, Excel)",
                color: Color(0xFFEEEEEE),
                textsize: 14,
                fontweight: FontWeight.w400,
              )
            ],
          ),
        ));
  }
}
