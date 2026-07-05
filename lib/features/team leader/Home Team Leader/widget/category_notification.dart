import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class CategoryNotification extends StatefulWidget {
  const CategoryNotification({super.key,required this.data,required this.color,this.onTap});
final String data;
final Color color;
final Function()? onTap;

  @override
  State<CategoryNotification> createState() => _CategoryNotificationState();
}

class _CategoryNotificationState extends State<CategoryNotification> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        width: 70,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: customText(text: widget.data,color: Colors.black,textsize: 12,fontweight: FontWeight.w400,),
      ),
    );
  }
}
