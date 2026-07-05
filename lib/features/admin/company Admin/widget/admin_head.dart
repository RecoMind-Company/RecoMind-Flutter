import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/profile/view/profile_view.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/data/notification_repo.dart';

import '../../../../shared/widgets/custom_text.dart';


class AdminHead extends StatefulWidget {
  const AdminHead({super.key,this.companyName = 'CName'});
  final companyName ;


  @override
  State<AdminHead> createState() => _AdminHeadState();
}

class _AdminHeadState extends State<AdminHead> {
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUnreadCount();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  text: 'Welcome to ${widget.companyName}, Ahmed!',
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
    );
  }
}
