import 'package:flutter/material.dart';

class Confocus extends StatefulWidget {
  const Confocus({
    super.key,
    required this.image,
    required this.label,
    required this.width,
    required this.height,
  });

  final String? image;
  final String? label;
  final double width;
  final double height;

  @override
  State<Confocus> createState() => _ConfocusState();
}

class _ConfocusState extends State<Confocus> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300), // مدة الانيميشن
        curve: Curves.easeInOut, // نوع الحركة
        alignment: Alignment.center,
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color:  Color(0xff2E3240),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isSelected ? Color(0xFF7EE3FF) : Colors.transparent, width: 3),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color:Color(0xFF7EE3FF).withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(widget.image!)),
            SizedBox(height: 8),
            Text(
              widget.label!,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: "Poppins"),
            )
          ],
        ),
      ),
    );
  }
}
