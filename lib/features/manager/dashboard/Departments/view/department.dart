import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart'; // تأكد من صحة مسار مشروعك

class HighlightsScreen extends StatefulWidget {
  const HighlightsScreen({super.key});

  @override
  State<HighlightsScreen> createState() => _HighlightsScreenState();
}

class _HighlightsScreenState extends State<HighlightsScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // التحريك التلقائي كل 3 ثوانٍ
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B15), // خلفية داكنة متطابقة لإبراز التدرجات
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Highlights',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),

              /// الـ PageView المخصص
              SizedBox(
                height: 250,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    _buildDelayedPlanCard(),  // الأحمر
                    _buildMilestonesCard(),   // الأخضر
                    _buildNewPlanCard(),      // الأزرق
                  ],
                ),
              ),

              const Gap(14),

              /// مؤشر النقاط التفاعلي
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  bool isSelected = _currentPage == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: isSelected ? 22 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF67D8F8) : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),

              const Gap(32),
              _buildDepartmentDetailCard(),
            ],
          ),
        ),
      ),
    );
  }

  /// 1. كارت الـ Plan Delayed (التدرج الأحمر المخصص)
  Widget _buildDelayedPlanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          // الـ stops هنا بتضمن إن الأسود مسيطر على معظم الكارت، والأحمر سايح في آخر 20% فقط
          stops: [0.6, 0.99, 1.0],
          colors: [
            Color(0xFF0A0000),
            Color(0xFF300304),
            Color(0xFF520507)
          ],
        ),
        border: Border.all(
          color: const Color(0xFF520507).withOpacity(0.15), // حواف خفيفة جداً متناسقة مع التوهج
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.error_outline_rounded, color: Color(0xFFE05353), size: 20),
              const Gap(8),
              const Text('Plan Delayed', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              customText(text: 'This Week', color: const Color(0xFF8E9AA6).withOpacity(0.8), textsize: 13),
            ],
          ),
          const Gap(14),
          _buildCardTag(Icons.campaign_outlined, 'Marketing'),
          const Gap(16),
          const Text('Social Media Growth Plan', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          const Gap(4),
          const Text('Campaign is 2 weeks behind schedule', style: TextStyle(color: Color(0xFF8E9AA6), fontSize: 13)),
          const Spacer(),
          _buildProgressRow('50%'),
          const Gap(8),
          _buildProgressBar(0.5, const Color(0xFFE05353)),
        ],
      ),
    );
  }

  /// 2. كارت الـ Milestones Reached (التدرج الأخضر المخصص)
  Widget _buildMilestonesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF000000), // اللون الداكن الأساسي
            Color(0xFF001B07), // التوهج الأخضر المخصص
          ],
        ),
        border: Border.all(color: const Color(0xFF001B07).withOpacity(0.5), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Color(0xFFD4E313), size: 20),
              const Gap(8),
              const Text('Milestones Reached', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              customText(text: 'This Week', color: const Color(0xFF8E9AA6).withOpacity(0.8), textsize: 13),
            ],
          ),
          const Gap(14),
          _buildCardTag(Icons.campaign_outlined, 'Marketing'),
          const Gap(16),
          const Text('Q1 Brand Awareness Plan', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          const Gap(4),
          Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF3CD182), size: 14),
              const Gap(6),
              Expanded(
                child: const Text('Target audience reached 10K this week', style: TextStyle(color: Color(0xFF8E9AA6), fontSize: 13)),
              ),
            ],
          ),
          const Spacer(),
          _buildProgressRow('75%'),
          const Gap(8),
          _buildProgressBar(0.75, const Color(0xFF3CD182)),
        ],
      ),
    );
  }

  /// 3. كارت الـ New Plan Added (التدرج الأزرق المخصص مع الشفافية)
  Widget _buildNewPlanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          // الـ stops هنا بتضمن إن الأسود مسيطر على معظم الكارت، والأحمر سايح في آخر 20% فقط
          stops: [0.6, 0.85, 1.0],
          colors: [
            Color(0xFF000D26), // اللون الأزرق الأغمق (مسيطر على معظم الكارت)
            Color(0xFF031433), // درجة دمج مظلمة جداً لتسييح الألوان تماماً ومنع أي خط فاصل
            Color(0xCC061C45), //
          ],
        ),
        border: Border.all(color: const Color(0xFF061C45).withOpacity(0.4), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle_outline_rounded, color: Color(0xFF67D8F8), size: 20),
              const Gap(8),
              const Text('New Plan Added', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              customText(text: 'This Week', color: const Color(0xFF8E9AA6).withOpacity(0.8), textsize: 13),
            ],
          ),
          const Gap(14),
          _buildCardTag(Icons.monetization_on_outlined, 'Sales'),
          const Gap(16),
          const Text('Q1 Brand Awareness Plan', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          const Spacer(),
          _buildProgressRow('5%'),
          const Gap(8),
          _buildProgressBar(0.05, const Color(0xFF67D8F8)),
        ],
      ),
    );
  }

  Widget _buildProgressRow(String percentage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Progress', style: TextStyle(color: Color(0xFF8E9AA6), fontSize: 14)),
        Text(percentage, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildProgressBar(double value, Color color) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: const Color(0xFF1E2333),
        valueColor: AlwaysStoppedAnimation<Color>(color),
        minHeight: 10,
      ),
    );
  }

  Widget _buildCardTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF8F9BB3), size: 16),
          const Gap(6),
          Text(label, style: const TextStyle(color: Color(0xFF8F9BB3), fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildDepartmentDetailCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF141A2B), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.campaign_outlined, color: Colors.white, size: 26),
              const Gap(10),
              const Text('Marketing', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF2C1D26), borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  children: [
                    Icon(Icons.circle, color: Color(0xFFE05353), size: 6),
                    Gap(6),
                    Text('1 Delayed', style: TextStyle(color: Color(0xFFE05353), fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
          const Gap(18),
          Row(
            children: [
              _buildInfoTag(Icons.person_outline_rounded, '15 Team Members'),
              const Gap(10),
              _buildInfoTag(Icons.assignment_outlined, '6 Team plans'),
            ],
          ),
          const Gap(22),
          _buildProgressRow('75%'),
          const Gap(8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.75,
              backgroundColor: Color(0xFF1F2638),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF67D8F8)),
              minHeight: 12,
            ),
          ),
          const Gap(20),
          Container(width: double.infinity, height: 1, color: const Color(0xFF1F2638)),
          const Gap(16),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              ),
              const Gap(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Magdy Mohammed', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                      const Gap(6),
                      const Icon(Icons.stars, color: Color(0xFF3AA6D4), size: 14),
                    ],
                  ),
                  const Gap(2),
                  const Text('Team Leader', style: TextStyle(color: Color(0xFF8E9AA6), fontSize: 13)),
                ],
              ),
              const Spacer(),
              SvgPicture.asset("assets/Team leader svg/comment.svg", width: 22, height: 22, fit: BoxFit.contain),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFF1C2235), borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF8E9AA6), size: 16),
          const Gap(6),
          customText(text: text, color: const Color(0xFFEEEEEE), textsize: 13),
        ],
      ),
    );
  }
}