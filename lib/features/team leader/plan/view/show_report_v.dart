import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_repo.dart';
import 'package:recomind/features/team%20leader/plan/data/plan_model.dart';
import 'package:recomind/features/team%20leader/plan/data/plan_repo.dart';
import 'package:recomind/features/team%20leader/plan/view/robot_loading.dart';
import 'package:recomind/features/team%20leader/report/view/report_view.dart';
import 'package:recomind/root.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';

class ValidationReportScreen extends StatefulWidget {
  const ValidationReportScreen({super.key, required this.savedReportModel, required this.Description});
  final SaveValidationResponseModel? savedReportModel;
  final String Description;

  @override
  State<ValidationReportScreen> createState() => _ValidationReportScreenState();
}

class _ValidationReportScreenState extends State<ValidationReportScreen> {
  final ActionPlanRepository _actionPlanRepository = ActionPlanRepository();
  final PlanRepository _planRepository = PlanRepository();
  bool _isExecuting = false;

  void _handleExecute() async {
    if (_isExecuting) return;

    setState(() {
      _isExecuting = true;
    });

    try {
      final result = await _planRepository.generateCustomPlan(widget.Description);

      if (mounted) {
        setState(() {
          _isExecuting = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RobotLoading(taskId: result.taskId!),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    final content = widget.savedReportModel?.content;

    return Scaffold(
      backgroundColor: const Color(0xFF060B1B),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Validation Report',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Gap(35),
                  _buildSectionTitle('Overview & Executive Summary'),
                  _buildBodyText(
                    content?.executiveSummary ?? 'No executive summary available for this plan.',
                  ),
                  const Gap(12),
                  _buildSectionTitle('Validation Decision & Score'),
                  _buildSubTitle('Decision:'),
                  _buildBodyText(content?.validationDecision ?? 'Pending Decision'),
                  _buildSubTitle('Confidence Score:'),
                  _buildBodyText(content?.confidenceScore != null ? '${content!.confidenceScore}%' : 'N/A'),
                  const Gap(12),
                  _buildSectionTitle('1. Key Findings & Scope Validation'),
                  _buildSubTitle('Industry & Peer Benchmarking:'),
                  _buildBodyText(content?.keyFindings?.precedentAnalysis ?? 'No benchmarking data available.'),
                  _buildSubTitle('Internal Company Resources:'),
                  _buildBodyText(content?.keyFindings?.resourceAssessment ?? 'No resource validation data available.'),
                  _buildSubTitle('Market Trends & External Signals:'),
                  _buildBodyText(content?.keyFindings?.marketTrends ?? 'No market trends validation available.'),
                  const Gap(12),
                  _buildSectionTitle('2. Recommendations'),
                  if (content?.recommendations == null || content!.recommendations!.isEmpty)
                    _buildBodyText('No recommendations provided for this plan.')
                  else
                    ...content.recommendations!.map((item) => _buildDotBulletItem(item)),
                  const Gap(12),
                  _buildSectionTitle('3. Risk Factors'),
                  if (content?.riskFactors == null || content!.riskFactors!.isEmpty)
                    _buildBodyText('No specific risk factors detected.')
                  else
                    ...content.riskFactors!.map((item) => _buildDotBulletItem(item)),
                  const Gap(12),
                  _buildSectionTitle('4. Next Steps'),
                  if (content?.nextSteps == null || content!.nextSteps!.isEmpty)
                    _buildBodyText('No next steps defined.')
                  else
                    ...content.nextSteps!.map((item) => _buildDotBulletItem(item)),
                ],
              ),
            ),
            if (_isExecuting)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: SwappedShrinkingLoading(strokeWidth: 3,size: 30,),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.white38, blurRadius: 20, spreadRadius: 0.5, offset: Offset.zero)],
          color: Color(0xFF060B1B),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _isExecuting ? null : _handleExecute,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7DD9FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Generate Tasks with AI',
                  style: TextStyle(
                    color: Color(0xFF060B1B),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Gap(14),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton(
                onPressed: _isExecuting
                    ? null
                    : () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const root(initialPage: 2),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: AppColor.primaryColor,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Exit Without Execution',
                  style: TextStyle(
                    color: Color(0xFF7DD9FF),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFE2E8F0),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSubTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFCBD5E1),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBodyText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 15,
          height: 1.35,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildDotBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 7),
            child: Icon(
              Icons.circle,
              size: 5,
              color: Color(0xFF94A3B8),
            ),
          ),
          const Gap(10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 15,
                height: 1.3,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}