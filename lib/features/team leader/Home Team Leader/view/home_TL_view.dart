import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/admin/Home_admin/data/home_admin_repo.dart';
import 'package:recomind/features/admin/profile/data/profile_model.dart';
import 'package:recomind/features/admin/profile/data/profile_repo.dart';
import 'package:recomind/features/admin/profile/view/profile_view.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/bloc/not_bloc.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/data/notification_repo.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/build_report_button.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/grid_cards.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/notification_TL.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/premium_card.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/show_notification_TL.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/validate_button.dart';
import 'package:recomind/features/team%20leader/invite/view/team_view.dart';
import 'package:recomind/features/team%20leader/report%20history/view/generate_report_view.dart';
import 'package:recomind/root.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../widget/action_Container.dart';

class HomeTlView extends StatefulWidget {
  const HomeTlView({super.key});

  @override
  State<HomeTlView> createState() => _HomeTeamleaderScreenState();
}

class _HomeTeamleaderScreenState extends State<HomeTlView> {
  final ProfileRepository _profileRepository = ProfileRepository();
  UserProfileModel? userProfile;
  bool _isLoading = false;
  bool isLoading = false;
  final HomeAdminRepo _homeAdminRepo = HomeAdminRepo();

  String _companyName = "CName";
  String _acceptedCount = '0';
  String _expiredCount = '0';
  String _pendingCount = '0';

  Future<void> fetchProfileData() async {
    try {
      setState(() {
        isLoading = true;
      });

      final result = await _profileRepository.getUserProfile();

      setState(() {
        userProfile = result;
        isLoading = false;
      });
    } on ApiError catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching profile: $e");
    }
  }

  bool notification = false;
  int _unreadCount = 0;

  Future<void> _fetchUnreadCount() async {
    try {
      final count = await NotificationRepository().getUnreadCount();
      if (mounted) setState(() => _unreadCount = count);
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUnreadCount();
    fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Containerwid(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ✅ الحل هنا: لف الـ Row الداخلي بالكامل بـ Expanded عشان يحترم مساحة الشاشة وزر الإشعارات
                        Expanded(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ProfileView()),
                                  );
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Color(0xFF151B29),
                                  radius: 23,
                                  backgroundImage: AssetImage("assets/Team_Leader/home/Ellipse 79 (1).png"),
                                ),
                              ),
                              const SizedBox(width: 10),

                              // الآن الـ Flexible أو Expanded هنا هتشتغل بشكل سليم تماماً
                              Expanded(
                                child: Skeletonizer(
                                  enabled: userProfile?.name == null,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min, // يفضل إضافة هذه لضمان عدم أخذ مساحة رأسية زائدة
                                    children: [
                                      Text(
                                        'Welcome, ${userProfile?.name ?? "User"}!',
                                        style: const TextStyle(
                                          color: Color(0XFFEEEEEE),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis, // عشان لو الاسم طويل جداً ما يضربش الشاشة
                                      ),
                                      const Gap(2),
                                      const Text(
                                        'Moving forward together',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Gap(15), // مسافة أمان صغيرة بين البيانات وبين زر الإشعارات

                        /// Notification Icon
                        Stack(
                          clipBehavior: Clip.none, // عشان لو حجم رقم الإشعارات كبر ما يتقصش
                          children: [
                            GestureDetector(
                              onTap: () => setState(() => notification = true),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF060B1B),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.notifications_none,
                                  color: AppColor.primaryColor,
                                  size: 35,
                                ),
                              ),
                            ),
                            if (_unreadCount > 0)
                              Positioned(
                                right: -2, // ترحيل بسيط لبره الكارت عشان الشكل الجمالي
                                top: -2,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  constraints: const BoxConstraints(
                                    minWidth: 18, // يضمن تفادي تشوه الدائرة لو الرقم من خانتين
                                    minHeight: 18,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$_unreadCount',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(40),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                            text: "Quick Actions",
                            color: CupertinoColors.white,
                            textsize: 20,
                            fontweight: FontWeight.w500),
                        Gap(15),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                1,
                                (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        root(initialPage: 2,category: 1,)));
                                          },
                                          child: ActionContainer()),
                                    )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(40),
                  SizedBox(
                    height: 210,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        PremiumCard(
                          title: "Turn reports into AI-driven plans",
                          text1: "AI-Generated Plans",
                          text2: "built",
                          text3: "automatically from your insights",
                          text4: "Actionable Steps",
                          text5: "Not just ",
                          text6: "numbers, but clear tasks you\ncan act on",
                        ),
                        const SizedBox(width: 10),
                        PremiumCard(
                            title: "Plans That Evolve With You",
                            text1: "Target-Oriented",
                            text2: "Every step",
                            text3: "Aligned with your KPIs",
                            text4: "Dynamic Update",
                            text5: "Plans that",
                            text6: "adapt as your data changes\n         "),
                      ],
                    ),
                  ),
                  Gap(24),
                  BuildReportButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GenerateReportView()));
                    },
                  ),
                  Gap(24),

                  /// card man
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Center(
                          child: Container(
                            width: 370,
                            height: 220,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF0077A8),
                                    Color(0xFF003B57),
                                    Color(0xFF02101D)
                                  ],
                                  stops: [
                                    0.01,
                                    0.08,
                                    0.20
                                  ]),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: -20,
                                    bottom: 0,
                                    top: 0,
                                    child: Image.asset(
                                        'assets/Team_Leader/man.png'),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                              "Let's turn it into\nreality.",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 10),
                                          const Text(
                                              "Validate your idea, and turn it\ninto actionable tasks.",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14)),
                                          Gap(20),
                                          ValidateButton()
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Gap(40),
                        Center(
                          child: Container(
                            width: 370,
                            height: 220,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF0077A8),
                                    Color(0xFF003B57),
                                    Color(0xFF02101D)
                                  ],
                                  stops: [
                                    0.01,
                                    0.08,
                                    0.20
                                  ]),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: -20,
                                    bottom: 0,
                                    top: 0,
                                    child: Image.asset(
                                        'assets/Team_Leader/manthink.png'),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                              "Have an idea and want to\nsee its impact on your\ncompany?",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 10),
                                          const Text(
                                              "Validate your ideas before you\ninvest time, money, or effort.",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14)),
                                          Gap(20),
                                          ValidateButton()
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Gap(90),
                ],
              ),
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
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeamView(),
                    ));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  "assets/Team_Leader/add-user-svgrepo-com.svg",
                  color: Colors.black,
                  height: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
