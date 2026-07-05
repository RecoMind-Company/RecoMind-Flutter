import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/admin/invite%20Admin/data/invite_repo.dart';
import 'package:recomind/features/admin/invite%20Admin/widget/invite_successfully_message.dart';
import 'package:recomind/features/admin/profile/view/profile_view.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/bloc/not_bloc.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/data/notification_repo.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/admin_head.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/show_notification_TL.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/features/admin/Home_admin/data/home_admin_repo.dart';
import 'package:recomind/features/admin/Home_admin/data/home_admin_model.dart';
import '../widget/invite_card.dart' show InviteCard;

class InviteView extends StatefulWidget {
  const InviteView({super.key});

  @override
  State<InviteView> createState() => _InvitesScreenState();
}

class _InvitesScreenState extends State<InviteView> {
  bool notification = false;

  String _companyName = "CName";
  String _acceptedCount = '0';
  String _expiredCount = '0';
  String _pendingCount = '0';

  Future<void> _loadDashboardData() async {
    try {
      final companySetup = await _homeAdminRepo.getSetup();
      final String companyId = companySetup.id ?? "";

      final results = await Future.wait([
        _homeAdminRepo.getAcceptedInvitations(companyId),
        _homeAdminRepo.getExpiredInvitations(companyId),
        _homeAdminRepo.getPendingInvitations(companyId),
      ]);

      if (mounted) {
        setState(() {
          _companyName = companySetup.name ?? "CName";
          _acceptedCount = results[0].length.toString();
          _expiredCount = results[1].length.toString();
          _pendingCount = results[2].length.toString();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error loading data: $e")),
        );
      }
    }
  }

  final HomeAdminRepo _homeAdminRepo = HomeAdminRepo();
  final InviteRepo _inviteRepo = InviteRepo();
  bool isInvite = false;
  bool _isLoading = true;
  bool _isSendingInvite = false; // ✨ متغير لحالة تحميل إرسال الدعوة الجديدة


  List<InvitationModel> _expiredInvites = [];
  List<InvitationModel> _pendingInvites = [];

  @override
  void initState() {
    super.initState();
    _loadInvitesData();
    _loadDashboardData();
  }

  Future<void> _loadInvitesData() async {
    try {
      final companySetup = await _homeAdminRepo.getSetup();
      final String companyId = companySetup.id ?? "";

      final expiredResults = await _homeAdminRepo.getExpiredInvitations(companyId);
      final pendingResults = await _homeAdminRepo.getPendingInvitations(companyId);

      if (mounted) {
        setState(() {
          _companyName = companySetup.name ?? "CName";
          _expiredInvites = expiredResults;
          _pendingInvites = pendingResults;
          _isLoading = false;
        });
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

  // ✨ دالة معالجة الضغط لإعادة إرسال الدعوة
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

      // تحديث البيانات الإجمالية بعد نجاح الإرسال لتنتقل الدعوة من Expired إلى Pending تلقائياً
      await _loadInvitesData();

      if (mounted) {
        setState(() {
          _isSendingInvite = false;
          isInvite = true; // عرض رسالة النجاح الخضراء
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

                // Header
                AdminHead(companyName: _companyName,ontap: (){setState(() {
                  notification = !notification;
                });},),

                const Gap(40),

                _isLoading
                    ? const Expanded(
                  child: Center(
                    child: SwappedShrinkingLoading(size: 50, strokeWidth: 5),
                  ),
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
                              ontap: () => _handleReinvite("${invite.userName}@gmail.com"), // ✨ تمرير الإيميل للدالة المحدثة
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
          if (notification)
            Positioned.fill(
              child: Material(
                color: Colors.black.withOpacity(0.5),
                child: BlocProvider(
                  create: (context) =>
                      NotificationBloc(NotificationRepository()),
                  child: ShowNotificationTl(
                    cancel: () {
                      setState(() {
                        notification = false;
                      });
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}