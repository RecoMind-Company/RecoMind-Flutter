import 'package:flutter/material.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/AI_All_set.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/step_1_widget.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/step_2_widget.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/step_3_widget.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/step_4_widget.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/step_5_widget.dart';
import 'package:recomind/shared/widgets/container.dart';


class RobotRoot extends StatefulWidget {
  const RobotRoot({super.key});

  @override
  State<RobotRoot> createState() => _RobotRootState();
}

class _RobotRootState extends State<RobotRoot> {
  int currentStep = 0;

  final List<Widget> steps = [
    Step1Widget(),
    Step2Widget(),
    Step3Widget(),
    Step4Widget(),
    Step5Widget(),
    AiAllSet()
  ];

  @override
  void initState() {
    super.initState();
    startChangingSteps();
  }

  Future<void> startChangingSteps() async {
    for (int i = 0; i < steps.length; i++) {
      await Future.delayed(Duration(seconds: 2));
      setState(() => currentStep = i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Center(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: steps[currentStep],
          ),
        ),
      ),
    );
  }
}