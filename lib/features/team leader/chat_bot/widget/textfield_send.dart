import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class TextfieldSend extends StatelessWidget {
  TextfieldSend({super.key, required this.onSave});

  final Function(String message) onSave;
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    onSave(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 25),
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: 279,
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _sendMessage(),
              maxLines: null,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: "Type your message here...",
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF7F7F7F),
                ),
                fillColor: const Color(0xFF3C3E45),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ),
          const Gap(10),
          const Icon(
            CupertinoIcons.mic,
            color: Color(0xFF7F7F7F),
            size: 30,
          ),
          const Gap(10),
          GestureDetector(
            onTap: _sendMessage,
            child: SizedBox(
              width: 40,
              height: 40,
              child: SvgPicture.asset(
                "assets/Team leader svg/send.svg",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
