import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/auth/log%20in%20views/log%20in/data/login_repository.dart';
import 'package:recomind/features/auth/log%20in%20views/log%20in/widget/password_field.dart';
import 'package:recomind/root.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../../../sign up views/sign up/views/sign_Up.dart';
import '../../../sign up views/sign up/widget/diver_Sign_Up.dart';
import '../../verify_login & welcome/view/enter_Email.dart';


class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isPasswordValid = false;
  bool isChecked = false;

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
  /// login
  LoginRepository authRepo = LoginRepository();

  Future<void> login() async {
    try{
      setState(() {
        isLoading = true;
      });
      final user = await authRepo.logIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if(user != null ){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => root()),
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
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    constraints: BoxConstraints(
                        minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Gap(40),
                            const customText(
                              text: "Login",
                              color: Colors.white,
                              textsize: 32,
                              fontweight: FontWeight.bold,
                            ),
                            Gap(32),

                            /// Google + Microsoft Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _socialButton(
                                  image: "assets/Icons.png",
                                  text: "With Google",

                                ),
                                _socialButton(
                                  image: "assets/microsoft_svgrepo.com (2).png",
                                  text: "With Microsoft",
                                ),
                              ],
                            ),

                            Gap(32),

                            ///diver
                            DiverSignUp(),
                            const SizedBox(height: 16),
                            Container(alignment: Alignment.topLeft,
                                width: double.infinity,
                                child: customText(text: "Email",
                                  color: Color(0xFFB8ADAD),
                                  textsize: 16,)),
                            Gap(8,),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: _textField(
                                hint: "Enter Your Email",
                                icon: Icons.email_outlined,
                                controller: _emailController,

                              ),
                            ),

                            Container(alignment: Alignment.topLeft,
                                width: double.infinity,
                                child: customText(text: "Password",
                                    color: Color(0xFFB8ADAD),
                                    textsize: 16)),
                            Gap(8),

                            // Password Field
                            PasswordField(
                              passwordController: _passwordController,),

                            Gap(10),
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: _passwordController.text.isNotEmpty
                                      ? Row(
                                    children: [
                                      Icon(
                                        _isPasswordValid
                                            ? Icons.check_circle
                                            : Icons.error,
                                        color: _isPasswordValid
                                            ? Colors.greenAccent
                                            : Colors.redAccent,
                                        size: 18,
                                      ),
                                      Gap(6),
                                      customText(
                                        text: _isPasswordValid
                                            ? "Your password meets all requirements"
                                            : "Password must be at least 8 characters",
                                        color: _isPasswordValid
                                            ? Colors.greenAccent
                                            : Colors.redAccent,
                                        textsize: 12,
                                      ),
                                    ],
                                  )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    height: 23,
                                    width: 23,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFF7EE3FF)),
                                        borderRadius: BorderRadius.circular(8)),


                                    child: Checkbox(
                                      value: isChecked,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          isChecked = newValue!;
                                        });
                                      },
                                      focusColor: Color(0xff060B1B),
                                      side: BorderSide(
                                          color: Color(0xff060B1B)),


                                      activeColor: Color(0xff060B1B),
                                      checkColor: Color(0xFF7EE3FF),
                                    ),
                                  ),
                                ),
                                const customText(
                                    text: 'Remember me',
                                    textsize: 16, color: Color(0xffeeeeee)),

                                Spacer(flex: 20,),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => EnterEmail()));
                                    },
                                    child: customText(text: "Forgot Password?",
                                      color: Color(0xFF7EE3FF),
                                      textsize: 16,
                                      isunderline: true,)),

                                Spacer(flex: 1,)
                              ],),
                            )


                            , Gap(47),

                            isLoading==true ? Center(child: CircularProgressIndicator(),): button(onPressed: () {
                              login();
                            },
                                color: _isPasswordValid
                                    ? AppColor.primaryColor
                                    : Colors.grey.shade600,
                                borderColor:_isPasswordValid
                                    ? AppColor.primaryColor
                                    : Colors.grey.shade600,
                                buttonText: "Log In",
                                textColor: Colors.black),
                            Gap(47),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const customText(
                                  text: "Don't Have an account? ",
                                 color: Colors.white70,
                                      textsize: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUP()));
                                  },
                                  child: const customText(
                                   text: "Sing Up",
                                        color: Color(0xFF7EE3FF),
                                        fontweight: FontWeight.bold,
                                        textsize: 18,
                                    isunderline: true,
                                  ),
                                ),
                              ],
                            ),
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
    );
  }

  static Widget _socialButton({
    required String image,
    required String text,
  }) {
    return Container(
      width: 170,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFF060B1B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF7EE3FF)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const SizedBox(width: 8),
          customText(text: text,
              color: Colors.white, textsize: 14),
          SizedBox(width: 16,)
          , Image(image: AssetImage(image)),
        ],
      ),
    );
  }

  static Widget _textField({
    required String hint,
    required IconData icon,
    required TextEditingController controller

  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF060B1B),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(

          prefixIcon: Icon(icon, color: Colors.white54),

          hintText: hint,
          hintStyle: const TextStyle(
              color: Color(0xFFB8ADAD), fontFamily: "Poppins"),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}
