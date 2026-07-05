import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/admin/Home_admin/data/home_admin_repo.dart';
import 'package:recomind/features/admin/profile/data/profile_model.dart';
import 'package:recomind/features/admin/profile/data/profile_repo.dart';
import 'package:recomind/features/admin/profile/view/profile_view.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/data/notification_repo.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../shared/widgets/custom_text.dart';


class AdminHead extends StatefulWidget {
  const AdminHead({super.key,this.companyName = 'CName'});
  final companyName ;



  @override
  State<AdminHead> createState() => _AdminHeadState();
}

class _AdminHeadState extends State<AdminHead> {
  final ProfileRepository _profileRepository = ProfileRepository();
  UserProfileModel? userProfile;
  bool _isLoading = false;
  bool isLoading = false;
  final HomeAdminRepo _homeAdminRepo = HomeAdminRepo();

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
    } catch (e) {

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUnreadCount();
    fetchProfileData();
    _loadDashboardData();
  }
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: _companyName == "CName",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileView()));
              },
              child: const CircleAvatar(
                radius: 23,
                backgroundImage: AssetImage("assets/Home/Ellipse 79.png"),
              ),
            ),
            const Gap(10),
            Expanded(flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: 'Welcome to $_companyName, ${userProfile?.name}!',
                    color: const Color(0XFFEEEEEE),
                    fontweight: FontWeight.bold,
                    textsize: 16,
                  ),
                  const Gap(2),
                  const customText(
                    text: 'Moving forward together',
                    color: Colors.white54,
                    textsize: 14,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Stack(
              children: [
                GestureDetector(
                  onTap: () => setState(() => notification = true),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF060B1B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.notifications_none, color: AppColor.primaryColor, size: 35),
                  ),
                ),
                if (_unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        '$_unreadCount',
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
