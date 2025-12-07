import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/utils/pref_helper.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_model.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_repository.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_3.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/company_diver.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/header_all_company.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/multi_lins_textfield.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/upload_Button.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/diver_wid.dart';

class CompanySetup2 extends StatefulWidget {
  const CompanySetup2({super.key});

  @override
  State<CompanySetup2> createState() => _CompanySetup2State();
}

class _CompanySetup2State extends State<CompanySetup2> {
  final int PageNumber = 1;
  late bool isLoading = false ;
  final TextEditingController _description = TextEditingController();
  SetupRepository authRepo = SetupRepository();
   late setupModel getSetup;



  /// get setup
  Future<void> getsetupdata() async {
    try {
      final user = await authRepo.getSetup();
      setState(() {
        getSetup = user;
      });
    } on ApiError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    }
  }

  ///update company //description
  Future<void> description() async {
    try{
      final token = await PrefHelper.getToken();
      setState(() {
        isLoading = true;
      });
      final user = await authRepo.description(
          "$token",
          getSetup?.name ?? "",
          getSetup?.industry ?? "",
          getSetup?.country ?? "",
          getSetup?.size ?? "",
          getSetup?.code ?? "",
          _description.text.trim()
      );
      if(user != null ){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CompanySetup3()),
        );
      }
      setState(() {
        isLoading = false;
      });

    }on ApiError catch(e){
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message),backgroundColor: Colors.red,));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsetupdata();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Containerwid(
            child: Column(
          children: [
            HeaderAllCompany(Pagenumber: PageNumber),
            Gap(40),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Business Description",
                        color: Color(0xFFEFEFEF),
                        fontweight: FontWeight.w400,
                        textsize: 16,
                      ),
                      customText(
                        text:
                            "You can write a short description or upload a file",
                        color: Color(0xFFEFEFEF),
                        fontweight: FontWeight.w500,
                        textsize: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  MultiLinsTextfield(controller: _description,),
                  Gap(20),
                  CompanyDiver(width: 75,text: "Or upload your company profile",),
                  Gap(16),
                  UploadButton(),
                  Gap(30),
                  isLoading == true ? CupertinoActivityIndicator():button(
                    color: AppColor.primaryColor,
                    buttonText: "Next",
                    textColor: Colors.black,
                    borderColor: AppColor.primaryColor,
                    onPressed: (){
                      // description();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CompanySetup3()),
                      );
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
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
