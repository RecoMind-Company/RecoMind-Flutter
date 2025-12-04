import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recomind/screens/Admin/Home/Comany/com_screen.dart';
import 'package:recomind/screens/Admin/Home/invites/invite_screen.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
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
              stops: [
                0.0001,
                0.02,
                0.12
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            // Profile header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 23,
                    backgroundImage: AssetImage("assets/Home_admin/Ellipse 79.png"),
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
                            fontSize: 18),
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
                    child: const Icon(Icons.notifications_none,
                        color: Color(0xff65B7D1), size: 28),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

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
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Image(
                          image: AssetImage(
                              "assets/Home_admin/fluent_people-team-20-regular.png")),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          _StatColumn(label: 'Accepted Invites', value: '9'),
                          VerticalDivider(
                            color: Color(0xff2F5368),
                            width: 2,
                            endIndent: 16,
                            indent: 16,
                          ),
                          _StatColumn(label: 'Expired Invites', value: '6'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "10 members haven't joined yet",
                      style: TextStyle(
                          color: Color(0xffEFEFEF),
                          fontSize: 20,
                          fontFamily: "Poppins"),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7EE3FF),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 8,
                        ),
                        child: const Text(
                          'Track Invites',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // ✅ Bottom navigation bar (Interactive)
            Container(
              height: 100,
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavItem(
                    Icon: "assets/Home_admin/SVG_Icon/Default.svg",
                    label: 'Home_admin',
                    isActive: _selectedIndex == 0,
                    onTap: () => _onNavTap(0),
                  ),
                  _NavItem(
                      Icon: "assets/Home_admin/SVG_Icon/Email.svg",
                      label: 'Invites',
                      isActive: _selectedIndex == 1,
                      onTap: () {
                        _onNavTap(1);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InvitesScreen()));
                      }),
                  _NavItem(
                    Icon: "assets/Home_admin/SVG_Icon/company.svg",
                    label: 'Company',
                    isActive: _selectedIndex == 2,
                    onTap: () {
                      _onNavTap(2);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompanyScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
              color: Color(0xffeeeeee), fontSize: 15, fontFamily: "Poppins"),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins"),
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final String Icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.Icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            width: 60,
            height: 32,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xff7EE3FF) : Color(0xff070C1E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(Icon,
                colorFilter: isActive
                    ? const ColorFilter.mode(
                        Color(0xff060B1B),
                        BlendMode.srcIn,
                      )
                    : const ColorFilter.mode(
                        Color(0xff7EE3FF),
                        BlendMode.srcIn,
                      )),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF00E5FF),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
