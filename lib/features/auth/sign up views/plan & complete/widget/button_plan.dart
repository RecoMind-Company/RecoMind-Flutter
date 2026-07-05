import 'package:flutter/material.dart';

import '../view/complete.dart';


class ButtonPlan extends StatelessWidget {
   ButtonPlan({super.key,required this.onTap});
Function() onTap;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container( alignment: Alignment.center,width: 300,
        height: 44,
        decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xFFADEDFF),
              Color(0xFF59DBFF),],stops: [0.01,0.80]
        ),boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.8), // لون الإضاءة
            blurRadius: 8, // مدى انتشار الضوء
            spreadRadius: 0.01, // قوة الضوء الخارجة
          ),
        ],
          border: Border.all(color: Color(0xFF48C6FF)),borderRadius: BorderRadius.circular(8),
        ),
        child: Text("Subscribe" , style: TextStyle(fontFamily: "Poppins",color: Colors.black,fontSize: 20),),
      ),
    );
  }
}
