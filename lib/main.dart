import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ 1. استيراد هذه الحزمة للتحكم في خصائص النظام
import 'package:recomind/features/admin/Home_admin/view/home_view_admin.dart';
import 'package:recomind/features/auth/log%20in%20views/log%20in/view/log_in.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/view/department_1_verification.dart';
import 'package:recomind/features/auth/sign%20up%20views/plan%20&%20complete/view/plan.dart';
import 'package:recomind/features/auth/sign%20up%20views/sign%20up/views/sign_Up.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/view/home_TL_view.dart';
import 'package:recomind/features/team%20leader/dashboard/view/suggest_plan.dart';
import 'package:recomind/features/team%20leader/invite/view/add_by_emial.dart';
import 'package:recomind/features/team%20leader/report%20history/view/full_screen.dart';
import 'package:recomind/root.dart';
import 'package:recomind/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash_screen(),
    );
  }
}