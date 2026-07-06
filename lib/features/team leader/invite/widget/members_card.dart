import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/team%20leader/invite/data/invite_model.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class MembersCard extends StatefulWidget {
  const MembersCard({
    super.key,
    required this.member,
  });

  final InvitationStatusModel member;

  @override
  State<MembersCard> createState() => _MembersCardState();
}

class _MembersCardState extends State<MembersCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 360,
      // ✅ إلغاء الـ height والـ constraints الصارمة تماماً لمنع أي تضارب في الـ RenderFlex
      // جعلنا الـ Padding خفيف ومتناسق عشان الكارت يفضل سمارت وأنيق
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF141A2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // بياخد مساحة الـ Row فقط وهو مقفول، ومساحة الكل وهو مفتوح
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الـ Row العلوي الدائم
          Row(
            children: [
              Image.asset(
                "assets/Home/Ellipse 79.png",
                height: 36,
                width: 36,
              ),
              const Gap(20),

              Expanded(
                child: customText(
                  text: widget.member.userName ?? "Unknown User",
                  color: Colors.white,
                  fontweight: FontWeight.w400,
                  textsize: 16,
                ),
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: _isExpanded ? 0.5 : 0.0,
                    child: SvgPicture.asset("assets/down.svg"),
                  ),
                ),
              ),
            ],
          ),

          // العناصر الإضافية تظهر فقط وحصرياً عند الفتح
          if (_isExpanded) ...[
            const Gap(12),
            const Divider(color: Color(0xFF232D45), height: 1),
            const Gap(12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const customText(
                  text: "Status:",
                  color: Colors.white70,
                  textsize: 14,
                ),
                customText(
                  text: widget.member.status ?? "No Status",
                  color: Colors.green,
                  textsize: 14,
                  fontweight: FontWeight.bold,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}