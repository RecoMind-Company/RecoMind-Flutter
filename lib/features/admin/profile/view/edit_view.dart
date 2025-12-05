import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';


class EditView extends StatelessWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF060B1B),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(children: [
            Gap(70),
            Row(
              children: [
                Gap(5),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 35,
                    )),
                Gap(25),
                customText(
                  text: "Edit Personal data",
                  color: Colors.white,
                  fontweight: FontWeight.w400,
                  textsize: 28,
                )
              ],
            ),
            Gap(32),


            ///PROFILE PIC
            Stack(children: [

              ///profile picture
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/Home/man.png"),
              ),

              /// image edit
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {

                  },
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFB5B5B5),
                    radius: 25,
                    child: Icon(
                      FontAwesomeIcons.pencil, color: Colors.black, size: 20,),
                  ),
                ),
              )
            ],),
            Gap(32),

            ///Name
            textfield(hint: "Name",
              controller: TextEditingController(text: "Ahmed"),
              icon: FontAwesomeIcons.pen,),
            Gap(16),
            ///Email
            textfield(hint: "Email",
              controller: TextEditingController(text: "Ahmed@gmail.com"),
              icon: Icons.email_outlined,),
            Gap(16),
            ///Phone
            textfield(hint: "Phone",
              controller: TextEditingController(text: "010565780"),
              icon: CupertinoIcons.phone,),
            Gap(32),
            
            ///button
            button(onPressed: (){}, color: AppColor.primaryColor, borderColor: AppColor.primaryColor, buttonText: "Save Changes", textColor: Colors.black)

          ],

          ),
        ),

      ),
    );
  }
}
