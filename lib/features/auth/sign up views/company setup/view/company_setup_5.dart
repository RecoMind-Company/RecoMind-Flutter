import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_model.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_repository.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_success.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/header_all_company.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/little_textfield.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';
import 'package:recomind/shared/widgets/title_Text_Field.dart';

class CompanySetup5 extends StatefulWidget {
  const CompanySetup5({super.key});

  @override
  State<CompanySetup5> createState() => _CompanySetup5State();
}

class _CompanySetup5State extends State<CompanySetup5> {
  final int Pagenumber = 4;
  SetupRepository authRepo = SetupRepository();
  final TextEditingController? controllerserver = TextEditingController();
  final TextEditingController controllerDB = TextEditingController();
  final TextEditingController controllerUser = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
bool isLoading = false ;
  DBModel? dbModel;
  Future<void> postDB() async {
    try {
      setState(() {
        isLoading = true;
      });
      final userlist = await authRepo.postDB(
        "RicoMind",
        controllerserver?.text.trim() ?? "",
        controllerDB?.text.trim() ?? "",
        controllerUser?.text.trim() ?? "",
        controllerPassword?.text.trim() ?? "",
        "Sql Server",
      );
      dbModel = userlist[0];
      if (userlist != null) {
        print(dbModel!.id);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CompanySetupSuccess(review: userlist[0],)),
        );
      }
      setState(() {
        isLoading = false ;
      });
    } on ApiError catch (e) {
      setState(() {
        isLoading = false ;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: Colors.red,));
    }
  }
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
                LittleTextfield(Title: "Server", hint: "192.168.1.10",controller: controllerserver),
                LittleTextfield(Title: "Database", hint: "Company DB",controller: controllerDB),
              ],
            ) ,
              Gap(16),


            ///userid and db password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(children: [
                TitleTextField(text: "User ID"),
                Gap(4),
                textfield(hint: "Enter User ID",icon: CupertinoIcons.pen,controller: controllerUser,),
                Gap(16),
                TitleTextField(text: "Password"),
                Gap(4),
                textfield(hint: "Enter DB Password",icon: CupertinoIcons.lock,controller: controllerPassword),
                Gap(32),

                /// buttons
               isLoading == true ?  CupertinoActivityIndicator(color: AppColor.primaryColor,radius: 20,):button(
                  color: AppColor.primaryColor,
                  buttonText: "Proceed to Summary",
                  textColor: Colors.black,
                  borderColor: AppColor.primaryColor,
                  onPressed: (){
                    postDB();
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
