import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recomind/component/bottom_bar.dart';
import 'package:recomind/shared/widgets/container.dart';

class HomeTeamleaderScreen extends StatefulWidget {
  const HomeTeamleaderScreen({super.key});

  @override
  State<HomeTeamleaderScreen> createState() => _HomeTeamleaderScreenState();
}

class _HomeTeamleaderScreenState extends State<HomeTeamleaderScreen> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            stops: [0.0001, 0.02, 0.12],
          ),
        ),
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
                      Text(
                        'Welcome to CName, Ahmed!',
                        style: TextStyle(
                          color: Color(0XFFEEEEEE),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Moving forward together',
                        style: TextStyle(color: Colors.white54, fontSize: 14),
                      ),
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

            const SizedBox(height: 40),

            // ================= TOP CARDS SCROLL =================
            SizedBox(
              height: 210,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildPrimeCard(
                    title: "Turn reports into AI-driven plans",
                    text1: "AI-Generated Plans",
                    text2: "Automatically from your insights",
                  ),
                  const SizedBox(width: 10),
                  _buildPrimeCard(
                    title: "Plans That Evolve With You",
                    text1: "Target-Oriented",
                    text2: "Aligned with your KPIs",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ================= BUTTON =================
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: 44,
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7EE3FF),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyanAccent.withOpacity(0.5),
                        blurRadius: 11,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                  child: const Text(
                    "Build My Report",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ================= TITLE =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Key Metrics Overview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Colors.white,
                ),
              ),
            ),

            // ================= GRID =================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: AlignmentGeometry.bottomLeft,
                            end: AlignmentGeometry.topRight,
                            colors: [
                              const Color(0xFF060B1B),
                              const Color(0xFF003B57),
                            ]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ================= BOTTOM NAV =================
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: const Color(0xff070C1E),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              padding: const EdgeInsets.only(right: 20, left: 20,bottom: 20,top: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NavItem(
                      Icon: "assets/Home_admin/SVG_Icon/Default.svg",
                      label: 'Home_admin',
                      isActive: _selectedIndex == 0,
                      onTap: () => _onNavTap(0),
                    ),
                    NavItem(
                      Icon: "assets/Team_Leader/home/robot.svg",
                      label: 'ChatBot',
                      isActive: _selectedIndex == 1,
                      onTap: () => _onNavTap(1),
                    ),
                    NavItem(
                      Icon: "assets/Home_admin/SVG_Icon/Email.svg",
                      label: 'Invites',
                      isActive: _selectedIndex == 2,
                      onTap: () => _onNavTap(2),
                    ),
                    NavItem(
                      Icon: "assets/Home_admin/SVG_Icon/company.svg",
                      label: 'Company',
                      isActive: _selectedIndex == 3,
                      onTap: () => _onNavTap(3),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= CARD WIDGET =================
  Widget _buildPrimeCard({
    required String title,
    required String text1,
    required String text2,
  }) {
    return Stack(
      children: [
        Image(
          image: const AssetImage("assets/Team_Leader/home/Prime.png"),
          height: 210,
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
        ),
        Positioned(
          top: 70,
          left: 20,
          child: Row(
            children: [
              Image(
                image: const AssetImage("assets/Team_Leader/home/star2.png"),
                height: 20,
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF96E8FF),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    text2,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
