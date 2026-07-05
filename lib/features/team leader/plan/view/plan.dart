import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_repo.dart';
import 'package:recomind/features/team%20leader/plan/data/plan_repo.dart';
import 'package:recomind/features/team%20leader/plan/view/robot_loading.dart';
import 'package:recomind/features/team%20leader/plan/view/validation_plan.dart';
import 'package:recomind/features/team%20leader/plan/widget/button.dart';
import 'package:recomind/features/team%20leader/plan/widget/plan_card.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';

class PlanReviewScreen extends StatefulWidget {
  final String reportId;

  const PlanReviewScreen({super.key, required this.reportId});

  @override
  State<PlanReviewScreen> createState() => _PlanReviewScreenState();
}

class _PlanReviewScreenState extends State<PlanReviewScreen> {
  final PlanRepository _planRepository = PlanRepository();
  ActionPlanRepository _actionPlanRepository = ActionPlanRepository();

  bool _isLoading = true;
  bool _isExecuting = false;
  String _errorMessage = '';

  bool isShortTermChecked = false;
  bool isMidTermChecked = false;
  bool isLongTermChecked = false;

  String shortTermGoal = '';
  String shortTermAnalysis = '';
  List<String> shortTermActions = [];

  String midTermGoal = '';
  String midTermAnalysis = '';
  List<String> midTermActions = [];

  String longTermGoal = '';
  String longTermAnalysis = '';
  List<String> longTermActions = [];

  @override
  void initState() {
    super.initState();
    _loadPlanDetails();
  }

  Future<void> _loadPlanDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await _planRepository.fetchPlanById(widget.reportId);

      setState(() {
        if (response.shortTerm != null) {
          shortTermGoal = response.shortTerm!.goal ?? '';
          shortTermAnalysis = response.shortTerm!.analysis ?? '';
          shortTermActions = List<String>.from(response.shortTerm!.recommendations ?? []);
        }
        if (response.midTerm != null) {
          midTermGoal = response.midTerm!.goal ?? '';
          midTermAnalysis = response.midTerm!.analysis ?? '';
          midTermActions = List<String>.from(response.midTerm!.recommendations ?? []);
        }
        if (response.longTerm != null) {
          longTermGoal = response.longTerm!.goal ?? '';
          longTermAnalysis = response.longTerm!.analysis ?? '';
          longTermActions = List<String>.from(response.longTerm!.recommendations ?? []);
        }
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        if (error is ApiError) {
          _errorMessage = error.message;
        } else {
          _errorMessage = error.toString();
        }
      });
    }
  }

  // تعديل الدالة لتستقبل نوع الأكشن لتفريق "Execute" عن "Start Validation" بنفس الـ description
  void _handleExecute({required bool isValidation}) async {
    String descriptionInput = "";
    print("$shortTermGoal$shortTermAnalysis${shortTermActions}");
    if (isShortTermChecked) {
      descriptionInput = "$shortTermGoal$shortTermAnalysis${shortTermActions}";
    } else if (isMidTermChecked) {
      descriptionInput = "$midTermGoal$midTermAnalysis${midTermActions}";
    } else if (isLongTermChecked) {
      descriptionInput = "$longTermGoal$longTermAnalysis${longTermActions}";
    }

    if (descriptionInput.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a plan first')),
      );
      return;
    }

    setState(() {
      _isExecuting = true;
    });

    try {
      dynamic result;

      if (isValidation) {
        // إذا ضغط على Start Validation يستدعي الـ Endpoint المخصصة للـ ValidationReport
        result = await _actionPlanRepository.generateCustomPlanvalidation(descriptionInput);
      } else {
        // هنا يوضع استدعاء الـ Endpoint العادي الخاص بالـ Execute إذا كان مختلفاً مستقبلاً
        // حالياً سنتركه يستدعي الـ generateCustomPlan أو الميثود المخصصة للـ Execute لديك
        result = await _planRepository.generateCustomPlan(descriptionInput);
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
              builder: (context) => ValidatingPlanScreen(taskId:result.taskId!,Description: descriptionInput,),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060B1B),
      body: Stack(
        children: [
          _isLoading
              ? const Center(child: SwappedShrinkingLoading(size: 50,strokeWidth: 5,))
              : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage, style: const TextStyle(color: Colors.red, fontSize: 16)))
              : SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 120),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Plan Review',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const Gap(30),

                buildPlanCard(
                  title: "Short-Term Plan (0-3 months)",
                  goal: shortTermGoal,
                  actions: shortTermActions,
                  isChecked: isShortTermChecked,
                  onCheckChanged: (val) => setState(() {
                    isShortTermChecked = val!;
                    if (val) {
                      isMidTermChecked = false;
                      isLongTermChecked = false;
                    }
                  }),
                  onDelete: (index) => setState(() => shortTermActions.removeAt(index)),
                ),
                const Gap(20),

                buildPlanCard(
                  title: "Mid-Term Plan (3-6 months)",
                  goal: midTermGoal,
                  actions: midTermActions,
                  isChecked: isMidTermChecked,
                  onCheckChanged: (val) => setState(() {
                    isMidTermChecked = val!;
                    if (val) {
                      isShortTermChecked = false;
                      isLongTermChecked = false;
                    }
                  }),
                  onDelete: (index) => setState(() => midTermActions.removeAt(index)),
                ),
                const Gap(20),

                buildPlanCard(
                  title: "Long-Term Plan (6-12 months)",
                  goal: longTermGoal,
                  actions: longTermActions,
                  isChecked: isLongTermChecked,
                  onCheckChanged: (val) => setState(() {
                    isLongTermChecked = val!;
                    if (val) {
                      isShortTermChecked = false;
                      isMidTermChecked = false;
                    }
                  }),
                  onDelete: (index) => setState(() => longTermActions.removeAt(index)),
                ),
              ],
            ),
          ),
          if (_isExecuting)
            const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF76E4FF),
              ),
            ),
        ],
      ),
      bottomNavigationBar: (!_isLoading && _errorMessage.isEmpty && (isShortTermChecked || isMidTermChecked || isLongTermChecked))
          ? Container(
        height: 183,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.grey.shade700, blurRadius: 10, spreadRadius: 1)],
            color: const Color(0xFF060B1B)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(20),
            buildBottomButton(
              "Execute It",
              const Color(0xFF76E4FF),
              Colors.black,
                  () => _handleExecute(isValidation: false), // يمرر false لتنفيذ الـ Execute
            ),
            const Gap(10),
            buildBottomButton(
              "Start Validation",
              Colors.transparent,
              const Color(0xFF76E4FF),
                  () => _handleExecute(isValidation: true), // يمرر true لتنفيذ الـ Validation بنفس الداتا
              isBorder: true,
            ),
          ],
        ),
      )
          : const SizedBox.shrink(),
    );
  }
}