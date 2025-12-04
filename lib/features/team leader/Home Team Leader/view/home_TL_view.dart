import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/component/bottom_bar.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/build_report_button.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/grid_cards.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/premium_card.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class HomeTlView extends StatefulWidget {
  const HomeTlView({super.key});

  @override
  State<HomeTlView> createState() => _HomeTeamleaderScreenState();
}

class _HomeTeamleaderScreenState extends State<HomeTlView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),

            // ================= HEADER =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 23,
                    backgroundImage: AssetImage(
                        "assets/Team_Leader/home/Ellipse 79 (1).png"),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      customText(text:
                        'Welcome to CName, Ahmed!',
                          color: Color(0XFFEEEEEE),
                          fontweight: FontWeight.bold,
                          textsize: 18,
                      ),
                      Gap(2),
                      customText(
                        text: 'Moving forward together',
                        color: Colors.white54, textsize: 14),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF060B1B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.notifications_none,
                      color: Color(0xff65B7D1),
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            Gap(40),
            // ================= TOP CARDS SCROLL =================
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
                    text6: "adapt as your data changes\n         "
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ================= BUTTON =================
            BuildReportButton(),
            Gap(24),

            // ================= TITLE =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const customText(
                text: "Key Metrics Overview",
                  textsize: 18,
                  fontweight: FontWeight.w500,
                  color: Colors.white,
              ),
            ),

            // ================= GRID =================
            GridCards()
          ],
        ),
      ),
    );
  }
}
