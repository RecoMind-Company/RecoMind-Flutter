import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/Home_admin/data/home_admin_model.dart';
import 'package:recomind/features/admin/Home_admin/data/home_admin_repo.dart';
import 'package:recomind/features/admin/add%20team%20leader/view/add_to_department.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/widget/card_management.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/data/notification_repo.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../../add TL & manager/view/invite_TL.dart';

class ViewAlAdmin extends StatefulWidget {
   ViewAlAdmin({super.key});

  @override
  State<ViewAlAdmin> createState() => _ViewAlAdminState();
}

class _ViewAlAdminState extends State<ViewAlAdmin> {
  final List names = ["Khaled Omar", "Aya Omar", "Ahmed Omar","Omar mohammed"];

  final HomeAdminRepo _homeAdminRepo = HomeAdminRepo();
  int _selectedIndex = 0;
  bool _isLoading = false;
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
  List<InvitationModel> invites = [];
  Future<void> _loadDashboardData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final companySetup = await _homeAdminRepo.getSetup();
      final String companyId = companySetup.id ?? "";

      final results = await Future.wait([
        _homeAdminRepo.getAcceptedInvitations(companyId),
        _homeAdminRepo.getExpiredInvitations(companyId),
        _homeAdminRepo.getPendingInvitations(companyId),
      ]);


      if (mounted) {
        setState(() {
          invites = results[0];
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Gap(40),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(CupertinoIcons.back, color: Colors.white, size: 30),
                    ),
                  ],
                ),
                Gap(48),
                ///add tl
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                      text: "Team Leaders",
                      textsize: 20,
                      fontweight: FontWeight.w500,
                      color: const Color(0xFFFFFFFF),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddToDepartment(),));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.plus,
                              fontWeight: FontWeight.bold,
                            ),
                            const Gap(5),
                            customText(
                              text: 'Invite Team Leader',
                              textsize: 14,
                              fontweight: FontWeight.w400,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Gap(32),
                _isLoading
                    ? const SwappedShrinkingLoading(size: 30, strokeWidth: 3)
                    : invites.isEmpty
                    ? Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: customText(
                    text: "No Team Leader Accepted Yet",
                    color: Colors.amber,
                    textsize: 16,
                    fontweight: FontWeight.w500,
                  ),
                )
                    :Column(
                  children: List.generate(invites.length,(index) {
                    return Column(children: [
                      index != 0 ? Divider(
                        color: Color(0xFF03294A),
                        thickness: 1,) : Container(),
                      Gap(16),
                      CardManagement(gmail_copy: invites[index].expMessage!,Name: invites[index].userName!,),
                      Gap(16)

                    ],);
                  },)
                ),
                Gap(30)


              ],
            ),
          ),
        ),
      )),
    );
  }
}
