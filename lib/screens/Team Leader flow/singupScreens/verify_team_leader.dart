import 'package:flutter/material.dart';
import 'package:recomind/screens/Team%20Leader%20flow/singupScreens/report_team_leader.dart';
import 'package:recomind/splash_screen.dart';
import '../../../shared/views/verify/view/verify_shared.dart';



class verifyTeamLeader extends StatelessWidget {
  const verifyTeamLeader({super.key});

  @override
  Widget build(BuildContext context) {
    return VerificationScreen(
      navigatScreen: reportTeamLeader(),
    );
  }
}
