import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/utils/pref_helper.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_repository.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_2.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/dropDown.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/header_all_company.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/header_company_setup.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/title_Text_Field.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';

class CompanySetup1 extends StatefulWidget {
  const CompanySetup1({super.key});

  @override
  State<CompanySetup1> createState() => _CompanySetup1State();
}

class _CompanySetup1State extends State<CompanySetup1> {
  final TextEditingController _business_Industry_Controller = TextEditingController();
  final TextEditingController _Country_Controller = TextEditingController();
  final TextEditingController _Company_Size_Controller = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _webController = TextEditingController();
 bool isLoading = false ;
  final int Pagenumber = 0;

  /// setup
  SetupRepository authRepo = SetupRepository();

  Future<void> setup() async{
    try{
      final token = await PrefHelper.getToken();
      setState(() {
        isLoading = true;
      });
      final user = await authRepo.setup(
        adminId: token ?? "",
        name: _nameController.text.trim(),
        industry: _business_Industry_Controller.text.trim(),
        country: _Country_Controller.text.trim(),
        size: _Company_Size_Controller.text.trim(),
        website: _webController.text.trim(),
      );
      if(user != null ){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CompanySetup2()),
        );
      }
      setState(() {
        isLoading = false;
      });

    }on ApiError catch(e){
      print("---- UI ERROR ----");
      print(e.message);
      print("-------------------");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message),backgroundColor: Colors.red,));
    }
  }

  final ValueNotifier<String?> _selectedCountryNotifier = ValueNotifier<String?>("select");
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Containerwid(
            child: Stack(
          children: [
            Column(
              children: [
                ///head
                HeaderAllCompany(
                  Pagenumber: Pagenumber,
                ),
                Gap(16),
                customText(
                  text: "Company Profile",
                  color: Color(0xFFEFEFEF),
                  fontweight: FontWeight.w400,
                  textsize: 24,
                ),
                Gap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      TitleTextField(
                        text: "Company Name",
                      ),
                      textfield(
                        controller: _nameController,
                        hint: "Example",
                      ),
                      Gap(15),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                top: 780,
                left: 18,
                right: 18,
                child: isLoading==true ?Center(child: CupertinoActivityIndicator(color: AppColor.primaryColor,radius: 20,),):button(
                  onPressed: () {
                    // setup();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CompanySetup2()),
                    );
                  },
                  color: AppColor.primaryColor,
                  borderColor: AppColor.primaryColor,
                  textColor: Colors.black,
                  buttonText: "Next",
                )),
            Positioned(
                top: 655,
                left: 18,
                right: 18,
                child: Column(
                  children: [
                    TitleTextField(
                      text: "Company Website",
                    ),
                    textfield(
                      controller: _webController,
                      hint: "Example",
                    ),
                  ],
                )),
            Positioned(
                top: 545,
                left: 18,
                right: 18,
                child: Column(
                  children: [
                    TitleTextField(
                      text: "Company Size",
                    ),
                    Dropdown(
                      controller: _Company_Size_Controller,
                      items: ["50-100","100-200","200-500"],
                      selectedItem: _selectedCountryNotifier,
                      hints: "200-500",
                    ),
                  ],
                )),
            Positioned(
                top: 435,
                left: 18,
                right: 18,
                child: Column(
                  children: [
                    TitleTextField(
                      text: "Country",
                    ),
                    Dropdown(
                      controller: _Country_Controller,
                      items: ["Egypt","USA","Qatar","Japan"],
                      selectedItem: _selectedCountryNotifier,
                      hints:"Search Country" ,
                    ),
                  ],
                )),
            Positioned(
                top: 320,
                left: 18,
                right: 18,
                child: Column(
                  children: [
                    TitleTextField(
                      text: "Business Industry",
                    ),
                    Dropdown(
                      controller: _business_Industry_Controller,
                      items: ["Marketing","Sales","IT","HR"],
                      selectedItem: _selectedCountryNotifier,
                        hints: "EX : Marketing",
                    ),
                  ],
                )),
          ],
        )),
      ),
    );
  }
}
