import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/admin/invite%20Admin/data/invite_repo.dart';
import 'package:recomind/features/admin/invite%20Admin/widget/invite_card.dart';
import 'package:recomind/features/admin/invite%20Admin/widget/invite_successfully_message.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

// ✅ استيراد الـ Repository والـ Model الصحيحين المستخدمين في الـ TeamView
import 'package:recomind/features/team%20leader/invite/data/invite_repo.dart';
import 'package:recomind/features/team%20leader/invite/data/invite_model.dart';

class ExpiredInvite extends StatefulWidget {
  const ExpiredInvite({super.key});

  @override
  State<ExpiredInvite> createState() => _InvitesScreenState();
}

class _InvitesScreenState extends State<ExpiredInvite> {
  bool notification = false;

  final TeamInfoRepository _teamInfoRepository = TeamInfoRepository();
  final InviteRepo _inviteRepo = InviteRepo();

  bool isInvite = false;
  bool _isLoading = true;
  bool _isSendingInvite = false;

  // ✅ القوائم الخاصة بعرض البيانات القادمة من الـ API المشترك
  List<InvitationStatusModel> _expiredInvites = [];
  List<InvitationStatusModel> _pendingInvites = [];

  @override
  void initState() {
    super.initState();
    _loadInvitesData();
  }

  // ✅ الدالة المحدثة بالكامل للاعتماد على الـ Endpoints الجديدة
  Future<void> _loadInvitesData() async {
    try {
      // 1. جلب بيانات الفريق الأساسية أولاً للحصول على الـ companyId
      final teamInfo = await _teamInfoRepository.getTeamDetails();
      final String? companyId = teamInfo.companyId;

      if (companyId != null) {
        // 2. عمل جلب متوازي (Future.wait) لكل من الـ Expired والـ Pending في نفس الوقت لسرعة الأداء
        final results = await Future.wait([
          _teamInfoRepository.getInvitationsByStatus(companyId: companyId, status: "Expired"),
          _teamInfoRepository.getInvitationsByStatus(companyId: companyId, status: "Pending"),
        ]);

        if (mounted) {
          setState(() {
            _expiredInvites = results[0];
            _pendingInvites = results[1];
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
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error loading invites: $e")),
        );
      }
    }
  }

  Future<void> _handleReinvite(String? email) async {
    if (email == null || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("This invitation doesn't have a valid email.")),
      );
      return;
    }

    setState(() {
      _isSendingInvite = true;
    });

    try {
      await _inviteRepo.invite(email);

      // تحديث البيانات بعد الإرسال الناجح لتختفي من الـ Expired وتظهر في الـ Pending تلقائياً
      await _loadInvitesData();

      if (mounted) {
        setState(() {
          _isSendingInvite = false;
          isInvite = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSendingInvite = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send invite: $e")),
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
                stops: [0.0001, 0.02, 0.120],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(70),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(CupertinoIcons.back, color: Colors.white, size: 30),
                  ),
                ),
                const Gap(30),

                _isLoading
                    ? const Center(
                  child: SwappedShrinkingLoading(size: 50, strokeWidth: 5),
                )
                    : Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      /// Expired Section
                      if (_expiredInvites.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          child: customText(
                            text: "Expired Invites",
                            color: Colors.white,
                            textsize: 16,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                        const Gap(12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: _expiredInvites.length,
                          itemBuilder: (context, index) {
                            final invite = _expiredInvites[index];
                            return InviteCard(
                              ontap: () => _handleReinvite("${invite.userName}@gmail.com"),
                              name: invite.userName ?? "Unknown",
                              status: invite.status ?? "Expired",
                              statusColor: const Color(0xFFD65C5C),
                              buttonText: "Invite by Email",
                            );
                          },
                        ),
                        const Gap(25),
                      ],

                      /// Pending Section
                      if (_pendingInvites.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          child: customText(
                            text: "Pending Invites",
                            color: Colors.white,
                            textsize: 16,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                        const Gap(12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: _pendingInvites.length,
                          itemBuilder: (context, index) {
                            final invite = _pendingInvites[index];
                            return InviteCard(
                              ontap: () {},
                              name: invite.userName ?? "Unknown",
                              status: invite.status ?? "Pending",
                              statusColor: const Color(0xFFE8D95B),
                              subText: invite.expMessage ?? "Invitation pending",
                              buttonVisible: false,
                            );
                          },
                        ),
                      ],

                      if (_expiredInvites.isEmpty && _pendingInvites.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 80),
                          child: Center(
                            child: customText(
                              text: "No invitations found",
                              color: Colors.white,
                              textsize: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (_isSendingInvite)
            Container(
              color: Colors.black45,
              child: const Center(
                child: SwappedShrinkingLoading(size: 50, strokeWidth: 5),
              ),
            ),

          /// success message
          if (isInvite)
            InviteSuccessfullyMessage(
              ontap: () {
                setState(() {
                  isInvite = false;
                });
              },
            ),
        ],
      ),
    );
  }
}