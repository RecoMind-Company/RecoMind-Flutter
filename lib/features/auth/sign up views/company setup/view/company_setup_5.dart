import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_success.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/header_all_company.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/little_textfield.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';
import 'package:recomind/shared/widgets/title_Text_Field.dart';

class CompanySetup5 extends StatelessWidget {
  const CompanySetup5({super.key});

  final int Pagenumber = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Column(
          children: [
            /// head and title
            HeaderAllCompany(Pagenumber: Pagenumber),
            Gap(16),
            customText(text: "Database Setup",textsize: 24,fontweight: FontWeight.w400,color: Color(0xFFEFEFEF),),
            Gap(24),

            ///server and database
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LittleTextfield(Title: "Server", hint: "192.168.1.10"),
                LittleTextfield(Title: "Database", hint: "Company DB"),
              ],
            ) ,
              Gap(16),
            
            
            ///userid and db password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(children: [
                TitleTextField(text: "User ID"),
                Gap(4),
                textfield(hint: "Enter User ID",icon: CupertinoIcons.pen,),
                Gap(16),
                TitleTextField(text: "Password"),
                Gap(4),
                textfield(hint: "Enter DB Password",icon: CupertinoIcons.lock,),
                Gap(32),

                /// buttons
                button(
                  color: AppColor.primaryColor,
                  buttonText: "Proceed to Summary",
                  textColor: Colors.black,
                  borderColor: AppColor.primaryColor,
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CompanySetupSuccess(),));
                  },
                ),
                Gap(16),
                button(
                  color: Color(0xFF060B1B),
                  buttonText: "Back",
                  textColor: AppColor.primaryColor,
                  borderColor: AppColor.primaryColor,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ],),
            )
          ],
        ),
      ),
    );
  }
}
