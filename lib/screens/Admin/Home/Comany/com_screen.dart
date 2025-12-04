import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recomind/screens/Admin/Home/Home_page.dart';
import 'package:recomind/screens/Admin/Home/invites/invite_screen.dart';



class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  int _selectedIndex = 2;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            stops: [0.0001, 0.02, 0.120],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),

            // Header
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
                          fontSize: 18,
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
                    child: const Icon(Icons.notifications_none,
                        color: Color(0xff65B7D1), size: 28),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // Company Info Card
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
                    Image(image: AssetImage("assets/Home_admin/Vector.png")),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _InfoColumn(title: "Company Name", value: "Lorem"),
                        SizedBox(
                          height: 35,
                          child: VerticalDivider(
                            color: Color(0xff2F5368),
                            width: 2,
                            endIndent: 2,
                            indent: 2,
                          ),
                        ),
                        _InfoColumn(title: "Company Members", value: "16"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Menu options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  _MenuItem(
                    icon: Icons.people_outline,
                    label: "Members",
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _MenuItem(
                    icon: Icons.storage_outlined,
                    label: "Database Setup",
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ✅ Bottom Navigation Bar
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
                      onTap: () {
                        _onNavTap(0);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeDashboardScreen()),
                        );
                      }),
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
                    },
                  ),
                  _NavItem(
                    Icon: "assets/Home_admin/SVG_Icon/company.svg",
                    label: 'Company',
                    isActive: _selectedIndex == 2,
                    onTap: () => _onNavTap(2),
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

// ================== Info Column ==================
class _InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const _InfoColumn({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white60, fontSize: 13, fontFamily: "Poppins"),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins"),
        ),
      ],
    );
  }
}

// ================== Menu Item ==================
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF060B1B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                    color: Colors.white, fontSize: 15, fontFamily: "Poppins"),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                color: Color(0xFF7EE3FF), size: 18),
          ],
        ),
      ),
    );
  }
}

// ================== Nav Item ==================
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
              color: Color(0xFF00E5FF),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
