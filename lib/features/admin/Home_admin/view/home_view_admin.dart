import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/Home_admin/widget/home_wid.dart';
import 'package:recomind/features/admin/profile/view/profile_view.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/admin_head.dart';
import 'package:recomind/root.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/features/admin/Home_admin/data/home_admin_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/bloc/not_bloc.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/data/notification_repo.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/show_notification_TL.dart';

class HomeViewAdmin extends StatefulWidget {
  const HomeViewAdmin({super.key});

  @override
  State<HomeViewAdmin> createState() => _HomeViewAdminState();
}

class _HomeViewAdminState extends State<HomeViewAdmin> {
  final HomeAdminRepo _homeAdminRepo = HomeAdminRepo();
  int _selectedIndex = 0;
  bool _isLoading = true;
  bool notification = false;
  int _unreadCount = 0;

  Future<void> _fetchUnreadCount() async {
    try {
      final count = await NotificationRepository().getUnreadCount();
      if (mounted) setState(() => _unreadCount = count);
    } catch (e) {
      // معالجة الخطأ
    }
  }

  String _companyName = "CName";
  String _acceptedCount = '0';
  String _expiredCount = '0';
  String _pendingCount = '0';

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
    _fetchUnreadCount();
  }

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

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(70),
                // Profile header
                AdminHead(
                  companyName: _companyName,
                  ontap: () {
                    setState(() {
                      notification = !notification;
                    });
                    print("object");
                    print(notification);
                  },
                ),

                const Gap(50),

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
                    child: _isLoading
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.0),
                              child: SwappedShrinkingLoading(
                                size: 50,
                                strokeWidth: 5,
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Image(
                                    image: AssetImage(
                                        "assets/Home/fluent_people-team-20-regular.png")),
                              ),
                              const Gap(20),
                              SizedBox(
                                height: 70,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    StatColumn(
                                        label: 'Accepted Invites',
                                        value: _acceptedCount),
                                    const VerticalDivider(
                                      color: Color(0xff2F5368),
                                      width: 2,
                                      endIndent: 16,
                                      indent: 16,
                                    ),
                                    StatColumn(
                                        label: 'Expired Invites',
                                        value: _expiredCount),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              customText(
                                text:
                                    "$_pendingCount members haven't joined yet",
                                color: const Color(0xffEFEFEF),
                                textsize: 20,
                              ),
                              const Gap(16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const root(
                                          initialPage: 1,
                                          Role: "admin",
                                        ),
                                      ),
                                      (route) => false,
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
                const Spacer(),
              ],
            ),
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
