import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/screens/Admin/Home/Home_page.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';




class welcomeview extends StatefulWidget {
  const welcomeview({super.key});

  @override
  State<welcomeview> createState() => _setupState();
}

class _setupState extends State<welcomeview> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds:3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeDashboardScreen() ));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Containerwid(
          child: Column(children: [
            Gap(200),
            Container(child: customText(text: "Welcome back !" , textsize: 28 , color: Color(0xffEEEEEE ) , fontweight: FontWeight.bold),),
            Gap(7),
            Container(alignment:Alignment.center,child: customText(text: "Let’s get back to work" , textsize: 25 , color: Color(0xffEEEEEE ) , fontweight: FontWeight.bold , iscenter: true,))

            ,Gap(32),
            Image(image: AssetImage("assets/complete.png")),



          ],),
        )
    );
  }
}
