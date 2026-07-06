import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/team%20leader/invite/data/invite_model.dart';
import 'package:recomind/features/team%20leader/invite/data/invite_repo.dart';
import 'package:recomind/features/team%20leader/invite/view/add_by_emial.dart';
import 'package:recomind/features/team%20leader/invite/view/expired_invite.dart';
import 'package:recomind/features/team%20leader/invite/widget/members_card.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/features/admin/Home_admin/widget/home_wid.dart';


class TeamView extends StatefulWidget {
  const TeamView({super.key});

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  // ✅ تعريف الـ Repositories
  final TeamInfoRepository _teamInfoRepository = TeamInfoRepository();
  final TeamInfoRepository _invitationRepository = TeamInfoRepository();

  bool _isLoading = true;
  String _teamName = "Loading...";

  // ✅ قائمة لتخزين الأعضاء المقبولين القادمين من الـ API
  List<InvitationStatusModel> _acceptedMembers = [];

  @override
  void initState() {
    super.initState();
    _loadTeamAndMembersData();
  }

  Future<void> _loadTeamAndMembersData() async {
    try {
      // 1. جلب بيانات الفريق الأساسية أولاً للحصول على الـ companyId
      final teamInfo = await _teamInfoRepository.getTeamDetails();

      debugPrint("********************************************");
      debugPrint("🚀 NEW COMPANY ID: ${teamInfo.companyId}");
      debugPrint("📦 TEAM ID: ${teamInfo.teamId}");
      debugPrint("********************************************");

      if (teamInfo.companyId != null) {
        // 2. تمرير الـ companyId للـ Repo التاني وتثبيت الـ status كـ "Accepted" استاتيك
        final membersList = await _invitationRepository.getInvitationsByStatus(
          companyId: teamInfo.companyId!,
          status: "Accepted", // ✅ تثبيت الـ status كـ static Accepted
        );

        if (mounted) {
          setState(() {
            _teamName = teamInfo.teamName ?? "No Team Name";
            _acceptedMembers = membersList;
            _isLoading = false;
          });
        }
      } else {
        throw Exception("Company ID is null");
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _teamName = "Error Loading";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching data: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0077A8),
                    Color(0xFF003B57),
                    Color(0xFF060B1B),
                  ],
                  stops: [
                    0.0001,
                    0.02,
                    0.12
                  ]),
            ),
            child: _isLoading
                ? const Center(
              child: SwappedShrinkingLoading(
                size: 50,
                strokeWidth: 5,
              ),
            )
                : SingleChildScrollView( // لتجنب حدوث Overflow عند كثرة الموظفين
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(100),

                  // Stats card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF0077A8),
                              Color(0xFF003B57),
                              Color(0xFF070C1E),
                            ],
                            stops: [
                              0.0001,
                              0.03,
                              0.20
                            ]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.back,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                              const Gap(98),
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Image(
                                    image: AssetImage(
                                        "assets/Home/fluent_people-team-20-regular.png")),
                              ),
                            ],
                          ),
                          const Gap(20),

                          SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                StatColumn(
                                    label: 'Team Name',
                                    value: _teamName),
                                const VerticalDivider(
                                  color: Color(0xff2F5368),
                                  width: 2,
                                  endIndent: 16,
                                  indent: 16,
                                ),
                                StatColumn(
                                    label: 'Accepted Invites',
                                    value: _acceptedMembers.length.toString()), // عرض العدد الفعلي للدعوات المقبولة
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const customText(
                            text: "All active members are fully tracked",
                            color: Color(0xffEFEFEF),
                            textsize: 14,
                          ),
                          const Gap(16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ExpiredInvite(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7EE3FF),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 8,
                              ),
                              child: const customText(
                                text: 'Track Invites',
                                color: Colors.black,
                                fontweight: FontWeight.bold,
                                textsize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Gap(24),

                  /// members header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      customText(
                        text: "Current Members : ${_acceptedMembers.length}",
                        textsize: 18,
                        fontweight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>AddByEmail() ,));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const customText(
                            text: "Add Members",
                            color: Colors.black,
                            textsize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(20),

                  _acceptedMembers.isEmpty
                      ? const Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: customText(
                      text: "No accepted members found.",
                      color: Colors.white60,
                      textsize: 14,
                    ),
                  )
                      : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // لأننا نستخدم الـ SingleChildScrollView بالأعلى
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _acceptedMembers.length,
                    separatorBuilder: (context, index) => const Gap(16),
                    itemBuilder: (context, index) {
                      final member = _acceptedMembers[index];
                      return MembersCard(member: member,);
                    },
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}