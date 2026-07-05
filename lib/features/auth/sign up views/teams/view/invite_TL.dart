import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/auth/sign up views/teams/data/team_Model.dart';
import 'package:recomind/features/auth/sign up views/teams/data/team_Repo.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';
import 'package:recomind/shared/widgets/title_Text_Field.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InviteTl extends StatefulWidget {
  const InviteTl({super.key});

  @override
  State<InviteTl> createState() => _InviteTlState();
}

class _InviteTlState extends State<InviteTl> {
  final TeamRepo teamRepo = TeamRepo();

  bool isLoadingTeams = false;
  String? loadingDepartmentId;

  List<TeamNameModel> teams = [];
  final Map<String, TextEditingController> emailControllers = {};

  @override
  void initState() {
    super.initState();
    getTeams();
  }

  @override
  void dispose() {
    for (final controller in emailControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // ================= GET TEAMS =================
  Future<void> getTeams() async {
    try {
      setState(() => isLoadingTeams = true);

      final result = await teamRepo.getTeamNames();
      teams = result ?? [];

      for (final team in teams) {
        emailControllers.putIfAbsent(team.id, () => TextEditingController());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() => isLoadingTeams = false);
    }
  }

  // ================= INVITE =================
  Future<void> inviteLeader({
    required String email,
    required String departmentId,
  }) async {
    if (email.trim().isEmpty) return;

    try {
      setState(() => loadingDepartmentId = departmentId);

      final teamLeaderId = await teamRepo.invite(email);
      print("eeeeeeeeeeeeeeeee$teamLeaderId");

      await teamRepo.updateTeam(
        departmentId: departmentId,
        teamLeaderId: teamLeaderId,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Leader invited & assigned successfully"),
          backgroundColor: Colors.green,
        ),
      );

      emailControllers[departmentId]?.clear();
    } on ApiError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => loadingDepartmentId = null);
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(70),

                /// BACK
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),

                const Gap(32),

                /// LOADING
                if (isLoadingTeams)
                  Skeletonizer(
                    enabled: true,
                    child: Column(
                      children: List.generate(
                        3,
                            (_) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            TitleTextField(text: "Department"),
                            Gap(8),
                            SizedBox(height: 48),
                            Gap(12),
                            SizedBox(height: 44),
                            Gap(24),
                            Divider(color: Color(0xFF03294A)),
                            Gap(24),
                          ],
                        ),
                      ),
                    ),
                  )
                else if (teams.isEmpty)
                  const Center(
                    child: Text(
                      "No departments found",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                else
                  Column(
                    children: teams.map((team) {
                      final controller = emailControllers[team.id]!;
                      final isLoading = loadingDepartmentId == team.id;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleTextField(text: "${team.name} Department"),
                          const Gap(8),

                          textfield(
                            controller: controller,
                            hint: "Team Leader email",
                            icon: Icons.mail_outline_outlined,
                          ),

                          const Gap(12),

                          isLoading
                              ? const Center(
                            child: SwappedShrinkingLoading(size: 50,strokeWidth: 5,),
                          )
                              : button(
                            onPressed: () => inviteLeader(
                              email: controller.text,
                              departmentId: team.id,
                            ),
                            color: AppColor.primaryColor,
                            borderColor: AppColor.primaryColor,
                            buttonText: "Invite",
                            textColor: Colors.black,
                          ),

                          const Gap(24),
                          const Divider(color: Color(0xFF03294A)),
                          const Gap(24),
                        ],
                      );
                    }).toList(),
                  ),

                const Gap(16),

                Row(
                  children: const [
                    Icon(Icons.error_outline, color: Colors.white),
                    Gap(8),
                    customText(
                      text: "Leader will receive an invite via email",
                      fontweight: FontWeight.w500,
                      textsize: 12,
                      color: Colors.white,
                    ),
                  ],
                ),

                const Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
