import 'package:flutter/material.dart';
import 'package:recomind/features/admin/add%20TL%20&%20manager/view/invite_TL.dart';
import 'package:recomind/features/auth/log%20in%20views/log%20in/view/log_in.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_1.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_2.dart';
import 'package:recomind/features/auth/sign%20up%20views/plan%20&%20complete/view/plan.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/step_1_widget.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/view/company_setup_3.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/view/company_setup_4.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/view/company_setup_5.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/view/review_all_setup.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/department_1_verification.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/view/home_TL_view.dart';
import 'package:recomind/features/team%20leader/chat_bot/view/chat_bot_view.dart';
import 'package:recomind/features/team%20leader/report%20history/view/Expand.dart';
import 'package:recomind/features/team%20leader/report%20history/view/generate_report_view.dart';
import 'package:recomind/features/team%20leader/report/view/report_view.dart';
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
      home:splash_screen(),
    );
  }
}
