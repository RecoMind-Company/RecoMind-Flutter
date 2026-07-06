import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/bloc/task_update_bloc.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_model.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_repo.dart';
import 'package:recomind/features/team%20leader/plan/view/generate_plan.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class RobotLoading extends StatefulWidget {
  final String taskId;

  const RobotLoading({super.key, required this.taskId});

  @override
  State<RobotLoading> createState() => _RobotLoadingState();
}

class _RobotLoadingState extends State<RobotLoading> {
  bool _isLoading = true;
  String? _errorMessage;
  final PlanRepository _planRepository = PlanRepository();

  @override
  void initState() {
    super.initState();
    _fetchPlanResult();
  }

  Future<void> _fetchPlanResult() async {
    int retryCount = 0;
    const maxRetries = 50;

    while (retryCount < maxRetries && mounted) {
      try {
        final planResult = await _planRepository.getCustomPlanResult(widget.taskId);
        print(planResult);

        // هنا الـ planResult نوعه PlanResponse وهو متوافق تماماً الآن مع الشاشة التالية
        if (planResult.status == 'completed' || planResult.modules.isNotEmpty) {
          if (!mounted) return;
          // بدلاً من استدعاء GeneratedPlanScreen مباشرة، قم بعمل التالي:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => TaskUpdateBloc(PlanRepository()), // تأكد من تمرير الـ Repository المطلوب
                child: GeneratedPlanScreen(plan: planResult),
              ),
            ),
          );
          return;
        }

        await Future.delayed(const Duration(seconds: 4));
        retryCount++;

      } catch (e) {
        debugPrint("Task still processing on backend, retrying... (${retryCount + 1}/$maxRetries)");
        await Future.delayed(const Duration(seconds: 4));
        retryCount++;
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Plan generation took too long or failed on server.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF060B1B),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 25),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Executing Plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const Gap(50),
              customText(
                text: _errorMessage ?? "AI Generating Task",
                fontweight: FontWeight.w400,
                textsize: 22,
                color: _errorMessage != null ? Colors.redAccent : Colors.white,
              ),
              const Gap(30),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: SvgPicture.asset(
                  "assets/Robot/robo_position_2.svg",
                  height: screenSize.height * 0.45,
                  fit: BoxFit.contain,
                ),
              ),
              const Gap(45),
              if (_isLoading)
                const SwappedShrinkingLoading(
                  size: 40,
                  strokeWidth: 4,
                )
              else
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = null;
                      });
                      _fetchPlanResult();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7DD9FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Retry Connection",
                      style: TextStyle(
                        color: Color(0xFF060B1B),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}