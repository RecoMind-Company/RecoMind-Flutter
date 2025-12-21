import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/auth/sign%20up%20views/sign%20up/data/signup_repository.dart';
import 'package:recomind/features/auth/sign%20up%20views/verfy%20&%20almost/view/verify_View.dart';
import 'package:recomind/root.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/features/auth/sign%20up%20views/sign%20up/widget/password_rules.dart';
import 'package:recomind/features/auth/sign%20up%20views/sign%20up/widget/social_Button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import '../../../log in views/log in/view/log_in.dart';
import '../widget/diver_Sign_Up.dart';
import '../widget/password_Textfield.dart';
import '../../../../../shared/widgets/title_Text_Field.dart';

class SignUP extends StatefulWidget {
  SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isPasswordValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final password = _passwordController.text.trim();
    setState(() {
      _isPasswordValid = password.length >= 8;
    });
  }
bool isLoading = false;
  /// singUp
  signUpRepo authRepo = signUpRepo();

  Future<void> signUp() async {
    try{
      setState(() {
        isLoading = true;
      });
      final user = await authRepo.signUp(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if(user != null ){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => verifySignUpView()),
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
          SnackBar(content: Text("Try Again"),backgroundColor: Colors.red,));
    }
  }


  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Containerwid(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(flex: 5,),
                              /// title
                              customText(
                                text: "Sign Up",
                                color: Colors.white,
                                textsize: 32,
                                fontweight: FontWeight.bold,
                              ),
                              Gap(32),

                              /// Google + Microsoft Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SocialButton(
                                      image: "assets/Icons.png",
                                      text: "With Google"),
                                  SocialButton(
                                      image:
                                          "assets/microsoft_svgrepo.com (2).png",
                                      text: "With Microsoft"),
                                ],
                              ),
                              Gap(32),

                              /// Diver
                              DiverSignUp(),
                              Gap(16),


                              /// TextFields

                              ///Name
                              TitleTextField(text: "Name",),
                              textfield(
                                hint: "Enter Your Name",
                                icon: Icons.person_outline,
                              controller: _nameController,),
                              Gap(15),

                              ///email
                              TitleTextField(text: "Email",),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: textfield(
                                  hint: "Enter Your Email",
                                  icon: Icons.email_outlined,
                                  controller: _emailController,
                                ),
                              ),



                              /// Password Field
                              PasswordTextfield(passwordController: _passwordController,),
                              Gap(10),


                              ///paswword rules
                              PasswordRules(passwordController: _passwordController,isPasswordValid: _isPasswordValid,),
                              Gap(30),


                              ///Button
                              isLoading==true ? Center(child: CupertinoActivityIndicator(color: AppColor.primaryColor,radius: 20,),):
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 20),
                                  child: button(
                                      onPressed: () {
                                        signUp();
                                      },
                                      color: _isPasswordValid
                                          ? AppColor.primaryColor
                                          : Colors.grey.shade600,
                                      borderColor: _isPasswordValid
                                          ? AppColor.primaryColor
                                          : Colors.grey.shade600,
                                      buttonText: "Sing Up",
                                      textColor: Colors.black)),




                              const Spacer(), //{}
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 40),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const customText(
                                        text: "Already have an account? ",
                                        color: Colors.white70,
                                        textsize: 16,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Loginview()));
                                        },
                                        child: const customText(
                                          text: "Login",
                                          color: Color(0xFF7EE3FF),
                                         fontweight: FontWeight.bold,
                                          textsize: 18,
                                          isunderline: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(flex: 1,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
