import 'package:flutter/material.dart';
import 'package:recomind/features/auth/log%20in%20views/log%20in/view/log_in.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_2.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/view/review_all_setup.dart';
import 'package:recomind/root.dart';
import 'package:recomind/splash_screen.dart';
import 'features/admin/Home_admin/view/home_view_admin.dart';
import 'features/auth/log in views/verify_login & welcome/view/enter_Email.dart' show enterEmail;
import 'features/auth/sign up views/robot && department/view/start_AI_processing.dart' show StartAiProcessing;
import 'features/auth/sign up views/sign up/views/sign_Up.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:StartAiProcessing(),
    );
  }
}
