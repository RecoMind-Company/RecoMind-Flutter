import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/team%20leader/dashboard/data/plan_model.dart';
import 'package:recomind/features/team%20leader/dashboard/data/plan_repo.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';

void showEditPlanDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) => const Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      child: EditPlanDialogContent(),
    ),
  );
}

class EditPlanDialogContent extends StatefulWidget {
  const EditPlanDialogContent({Key? key}) : super(key: key);

  @override
  State<EditPlanDialogContent> createState() => _EditPlanDialogContentState();
}

class _EditPlanDialogContentState extends State<EditPlanDialogContent> {
  static int isSelectednum = -1;
  final ProposalsPlanRepository _repository = ProposalsPlanRepository();
  static List<ShortPlanDto> plans = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchPlans();
  }

  Future<void> _fetchPlans() async {
    final response = await _repository.getPlansByTeamId();
    if (mounted) {
      setState(() {
        _isLoading = false;
        if (response is ProposalsPlanResponseModel) {
          plans = response.shortPlanDtos;
        } else if (response is ApiError) {
          _errorMessage = response.message;
        } else {
          _errorMessage = "Something went wrong";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF060B1B),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 120,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              const Text(
                "Add To Plan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(flex: 1),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const Gap(20),
          Flexible(
            child: _isLoading
                ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SwappedShrinkingLoading(strokeWidth: 5, size: 50),
            )
                : _errorMessage != null
                ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            )
                : plans.isEmpty
                ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "No plans available",
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
            )
                : ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: plans.length,
              separatorBuilder: (context, index) => const Gap(14),
              itemBuilder: (context, index) {
                final plan = plans[index];
                return _buildMemberCard(
                  index: index,
                  name: plan.planName,
                  isSelected: isSelectednum == index,
                );
              },
            ),
          ),
          const Gap(24),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                if (isSelectednum != -1 && isSelectednum < plans.length) {
                  Navigator.pop(context, plans[isSelectednum]);
                } else {
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7DE6FF),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Done",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard({
    required int index,
    required String name,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelectednum = index;
        });
        print(plans[index].planId);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF111726),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: const Color(0xFF2B5C8F), width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            SvgPicture.asset("assets/Team_Leader/plan_icon.svg"),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Gap(2),
                  const Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            isSelected
                ? Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF4AC2E6), width: 2),
              ),
              child: const Icon(
                Icons.check,
                size: 16,
                color: Color(0xFF4AC2E6),
              ),
            )
                : Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}