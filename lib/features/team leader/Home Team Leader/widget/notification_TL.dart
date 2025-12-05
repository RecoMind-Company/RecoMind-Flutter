import 'package:flutter/material.dart';


class NotificationTl extends StatelessWidget {
  const NotificationTl({super.key, required this.ontap});
final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF060B1B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.notifications_none,
          color: Color(0xff65B7D1),
          size: 28,
        ),
      ),
    );
  }
}
