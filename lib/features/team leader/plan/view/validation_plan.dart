import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/team%20leader/plan/data/plan_model.dart';
import 'package:recomind/features/team%20leader/plan/data/plan_repo.dart';
import 'package:recomind/features/team%20leader/plan/view/show_report_v.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';

class ValidatingPlanScreen extends StatefulWidget {
  const ValidatingPlanScreen({super.key, required this.taskId , required this.Description});
  final String taskId;
  final String Description;

  @override
  State<ValidatingPlanScreen> createState() => _ValidatingPlanScreenState();
}

class _ValidatingPlanScreenState extends State<ValidatingPlanScreen> {
  int _currentStep = 0;
  final ActionPlanRepository _actionPlanRepository = ActionPlanRepository();

  SaveValidationResponseModel? _savedValidationResponse;

  bool _isApiDone = false;
  bool _isAnimationDone = false;

  @override
  void initState() {
    super.initState();
    _fetchAndSaveValidationData();
    _startAnimation();
  }

  Future<void> _fetchAndSaveValidationData() async {
    bool isLoaded = false;
    ValidationContentModel? fetchedContent;

    while (!isLoaded && mounted) {
      try {
        final result = await _actionPlanRepository.fetchValidationPlanResult(widget.taskId);

        if (result.executiveSummary != null && result.executiveSummary!.isNotEmpty) {
          fetchedContent = result;
          isLoaded = true;
        } else {
          await Future.delayed(const Duration(seconds: 3));
        }
      } catch (e) {
        debugPrint("Validation report still processing, retrying... Error: $e");
        await Future.delayed(const Duration(seconds: 3));
      }
    }

    // 2. إرسال البيانات للحفظ مع حقل الـ userRequest والـ status = 1 (Static)
    if (isLoaded && fetchedContent != null && mounted) {
      try {
        final requestBody = SaveValidationRequestModel(
          userRequest: widget.Description,
          content: fetchedContent,
          status: 1,
        );

        final saveResult = await _actionPlanRepository.addValidationReport(requestBody);
        _savedValidationResponse = saveResult;
      } catch (e) {
        debugPrint("Error saving validation report: $e");
      }
    }

    if (mounted) {
      setState(() {
        _isApiDone = true;
      });
      _navigateToNextScreenIfReady();
    }
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _currentStep = 1);

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _currentStep = 2);

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _currentStep = 3);

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _currentStep = 4);

    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;

    _isAnimationDone = true;
    _navigateToNextScreenIfReady();
  }

  void _navigateToNextScreenIfReady() {
    if (_isAnimationDone && _isApiDone && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ValidationReportScreen(
            savedReportModel: _savedValidationResponse,
            Description: widget.Description,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060B1B),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 25),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Validating Plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const Gap(30),
              const Center(
                child: Image(
                  image: AssetImage("assets/Team_Leader/validation.png"),
                ),
              ),
              const Gap(50),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "We're checking your plan across multiple\ndimensions to ensure feasibility and\nalignment with your business goals.",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xFFACACAC),
                        fontSize: 19,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(40),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2634),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildValidationRow("Similar Companies Benchmarking", 0),
                    const Gap(16),
                    _buildValidationRow("Company Resources Validation", 1),
                    const Gap(16),
                    _buildValidationRow("Market Trend Validation", 2),
                  ],
                ),
              ),
              const Gap(40),
              if (_currentStep == 4)
                const Column(
                  children: [
                    Text(
                      "Preparing your validation report — almost done!",
                      style: TextStyle(
                        color: Color(0xFFACACAC),
                        fontSize: 16,
                      ),
                    ),
                    Gap(24),
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: SwappedShrinkingLoading(strokeWidth: 3, size: 4),
                    ),
                  ],
                ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValidationRow(String text, int index) {
    bool isDone = _currentStep > index;
    bool isLoading = _currentStep == index;

    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isDone
                ? SvgPicture.asset("assets/Team_Leader/Group.svg")
                : isLoading
                ? const SizedBox(
              width: 14,
              height: 14,
              child: SwappedShrinkingLoading(strokeWidth: 2, size: 2),
            )
                : Container(
              key: const ValueKey('empty'),
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF63666F),
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}