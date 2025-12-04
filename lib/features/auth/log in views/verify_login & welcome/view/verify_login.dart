import 'package:flutter/material.dart';
import 'package:recomind/features/auth/log%20in%20views/verify_login%20&%20welcome/view/welcome.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_1.dart';
import 'package:recomind/features/auth/sign%20up%20views/verfy%20&%20almost/view/almost_View.dart';
import '../../../../../shared/views/verify/view/verify_shared.dart';



class VerifyLogin extends StatelessWidget {
  const VerifyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return VerificationScreen(
      navigatScreen: welcomeview(),
    );
  }
}
