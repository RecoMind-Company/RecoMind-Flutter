import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/team%20leader/dashboard/data/porposal_repo.dart';
import 'package:recomind/features/team%20leader/dashboard/view/suggest_plan.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';

import '../data/porposal_model.dart';

class ProposalsContentView extends StatefulWidget {
  const ProposalsContentView({super.key});

  @override
  State<ProposalsContentView> createState() => _ProposalsContentViewState();
}

class _ProposalsContentViewState extends State<ProposalsContentView> {
  final ProposalRepository _proposalRepository = ProposalRepository();
  late Future<dynamic> _proposalsFuture;
  static List<ProposalModel> list = [];

  @override
  void initState() {
    super.initState();
    _proposalsFuture = _proposalRepository.getProposals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: FutureBuilder<dynamic>(
          future: _proposalsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SwappedShrinkingLoading(size: 40, strokeWidth: 4),
              );
            }

            if (snapshot.hasError || snapshot.data is ApiError) {
              final errorMessage = snapshot.data is ApiError
                  ? (snapshot.data as ApiError).message
                  : "Something went wrong";
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            final List<ProposalModel> proposalsList = snapshot.data is List<ProposalModel>
                ? snapshot.data as List<ProposalModel>
                : [];
            list = proposalsList;

            if (proposalsList.isEmpty) {
              return const Center(
                child: Text(
                  "No plans found to be reviewed",
                  style: TextStyle(color: Color(0xFF56627C), fontSize: 15),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF67D8F8),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        "${proposalsList.length} Plans Need To be Reviewed",
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    physics: const BouncingScrollPhysics(),
                    itemCount: proposalsList.length,
                    separatorBuilder: (_, __) => const Gap(16),
                    itemBuilder: (context, index) {
                      final item = proposalsList[index];
                      return _buildProposalCard(
                        index: index,
                        title: item.userQuestion ?? "No Title",
                        description: item.content?.executiveSummary ?? "No description provided.",
                        suggestedBy: item.createdBy ?? "Unknown User",
                        role: item.status ?? "", // تمرير الحالة هنا
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProposalCard({
    required String title,
    required String description,
    required String suggestedBy,
    required String role,
    required int index,
  }) {
    // 💡 منطق تحديد ألوان النور بناءً على الحالة[cite: 1]
    Color statusColor = role == "Accepted"
        ? Colors.greenAccent
        : (role == "Rejected" ? Colors.redAccent : Colors.transparent);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuggestedPlanScreen(id: list[index].id),
          ),
        ).then((wasUpdated) {
          if (wasUpdated == true) {
            setState(() {
              _proposalsFuture = _proposalRepository.getProposals();
            });
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF141A2B),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(title,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
                      maxLines: 2),
                ),
                // 💡 حاوية الحالة المضيئة في أعلى اليمين[cite: 1]
                if (role == "Accepted" || role == "Rejected")
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: statusColor.withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: statusColor.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 0.1,
                        ),
                      ],
                    ),
                    child: Text(
                      role,
                      style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
            const Gap(14),
            const Text("Description", style: TextStyle(color: Color(0xFF56627C), fontSize: 12)),
            const Gap(4),
            Text(description,
                style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 14, height: 1.4), maxLines: 5),
            const Gap(16),
            Container(width: double.infinity, height: 0.8, color: const Color(0xFF1E2638)),
            const Gap(14),
            const Text("Suggested by", style: TextStyle(color: Color(0xFF56627C), fontSize: 12)),
            const Gap(10),
            Row(
              children: [
                const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFF262E42),
                    child: Icon(Icons.person, color: Colors.white, size: 20)),
                const Gap(12),
                Text(suggestedBy, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}