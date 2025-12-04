import 'package:flutter/material.dart';
import 'package:recomind/repeated_screen/complete.dart';
import 'package:recomind/screens/Team%20Leader%20flow/HomePages/mainHomePage/main_home_page.dart';


class compeleteTeamleader extends StatelessWidget {
  const compeleteTeamleader({super.key});

  @override
  Widget build(BuildContext context) {
    return completesetup(navigatscreen: HomeTeamleaderScreen(),);
  }
}
