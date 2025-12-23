import 'package:flutter/material.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/data/robot_repo.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/AI_All_set.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/step_1_widget.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/step_2_widget.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/step_3_widget.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/step_4_widget.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/step_5_widget.dart';
import 'package:recomind/shared/widgets/container.dart';

class RobotRoot extends StatefulWidget {
  RobotRoot({super.key, required this.Id});
  String Id;

  @override
  State<RobotRoot> createState() => _RobotRootState();
}

class _RobotRootState extends State<RobotRoot> {
  int currentStep = 0;
  RobotRep robotRep = RobotRep();

  bool isSuccess = false;
  bool isStopped = false;

  Future<void> robotRequest() async {
    try {
      final response = await robotRep.getRobot(widget.Id);
      if (response != null) {
        setState(() {
          isSuccess = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  final List<Widget> steps = [
    Step1Widget(),
    Step2Widget(),
    Step3Widget(),
    Step4Widget(),
    Step5Widget(),
    AiAllSet() // آخر خطوة
  ];

  @override
  void initState() {
    super.initState();
    startChangingSteps();
    robotRequest();
  }

  Future<void> startChangingSteps() async {
    int i = 0;

    while (!isStopped) {
      await Future.delayed(const Duration(seconds: 3));

      if (!mounted) return;


      if (isSuccess) {
        setState(() {
          currentStep = steps.length - 1;
        });
        isStopped = true;
        break;
      }

      setState(() {
        currentStep = i;
      });

      if (i == steps.length - 2) {
        i = 0;
      } else {
        i++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
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
