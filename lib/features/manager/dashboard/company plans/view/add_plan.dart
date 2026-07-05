import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_model.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_repo.dart';
import 'package:recomind/features/team%20leader/plan/view/robot_loading.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/container.dart';


class AddPlan extends StatefulWidget {
  const AddPlan({super.key});

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  final TextEditingController _textController = TextEditingController();

  late final PlanRepository _planRepository;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _planRepository = PlanRepository();
  }

  void _handleExecute() async {
    final userInput = _textController.text.trim();
    if (userInput.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please type something first')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // استلام الـ PlanResponse الموحد الذي يحتوي على الـ task_id والـ status والـ message
      final PlanResponse result = await _planRepository.generateCustomPlan(userInput);

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        // الانتقال لشاشة الـ RobotLoading وتمرير الـ response كامل لتنادي منه الـ endpoint التانية
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RobotLoading(taskId: result.taskId!),
          ),
        );
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      String errorMessage = 'Something went wrong';
      if (error is ApiError) {
        errorMessage = error.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(16),
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const Gap(40),
                const Text(
                  'Type What are You Thinking About ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const Gap(16),
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xFF141A29),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: TextField(
                    controller: _textController,
                    maxLines: null,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Ex: Open A new Branch',
                      hintStyle: TextStyle(
                        color: Color(0xFF56627C),
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const Gap(40),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleExecute,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF67D8F8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                      width: 30,
                      height: 30,
                      child: SwappedShrinkingLoading(
                        size: 40,
                        strokeWidth: 3,
                      ),
                    )
                        : const Text(
                      'Execute it',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}