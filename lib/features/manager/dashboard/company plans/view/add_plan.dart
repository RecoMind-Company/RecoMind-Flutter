import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_model.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_repo.dart';
import 'package:recomind/features/team%20leader/plan/data/plan_repo.dart';
import 'package:recomind/features/team%20leader/plan/view/robot_loading.dart';
import 'package:recomind/features/team%20leader/plan/view/validation_plan.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


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
  ActionPlanRepository _actionPlanRepository = ActionPlanRepository();
  bool _isExecuting = false;
  void _handleExecute({required bool isValidation}) async {
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
      dynamic result;

      if (isValidation) {
        // إذا ضغط على Start Validation يستدعي الـ Endpoint المخصصة للـ ValidationReport
        result = await _actionPlanRepository.generateCustomPlanvalidation(userInput);
      } else {
        // هنا يوضع استدعاء الـ Endpoint العادي الخاص بالـ Execute إذا كان مختلفاً مستقبلاً
        // حالياً سنتركه يستدعي الـ generateCustomPlan أو الميثود المخصصة للـ Execute لديك
        result = await _planRepository.generateCustomPlan(userInput);
      }

      print("this is result //////////////////////////////////////////$result");

      setState(() {
        _isExecuting = false;
      });

      if (mounted) {
        if (isValidation) {
          print(result.taskId!);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ValidatingPlanScreen(taskId:result.taskId!,Description: userInput,),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RobotLoading(taskId: result.taskId!),
            ),
          );
        }
      }
    } catch (error) {
      setState(() {
        _isExecuting = false;
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
            child:Column(
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
                _isLoading ? Center(child: SwappedShrinkingLoading(strokeWidth: 5,size: 50,)) :Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                          onPressed:() =>  _handleExecute(isValidation: false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF67D8F8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const customText(text:
                          'Execute it',
                            color: Colors.black,
                            textsize: 16,
                            fontweight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(15),
                    button(onPressed: (){
                       _handleExecute(isValidation: true);

                    }, color: AppColor.darkBlue, borderColor: AppColor.primaryColor, buttonText: "Validate it", textColor: AppColor.primaryColor),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}