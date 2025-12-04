import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key , required this.image , required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFF060B1B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF7EE3FF)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 8),
          customText(text: text,color: Colors.white,textsize: 14),
          SizedBox(
            width: 16,
          ),
          Image(image: AssetImage(image)),
        ],
      ),
    );
  }
}
