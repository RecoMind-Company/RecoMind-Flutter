import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recomind/screens/Admin/Home/Comany/com_screen.dart';
import 'package:recomind/screens/Admin/Home/Home_page.dart';

class InvitesScreen extends StatefulWidget {
  const InvitesScreen({super.key});

  @override
  State<InvitesScreen> createState() => _InvitesScreenState();
}

class _InvitesScreenState extends State<InvitesScreen> {
  int _selectedIndex = 1;

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

            const SizedBox(height: 40),

            // Expired Invites
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                "Expired Invites",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),

            const InviteCard(
              name: "Noreen Motaz",
              status: "Expired",
              statusColor: Color(0xFFD65C5C),
              buttonText: "Invite by Email",
            ),
            const InviteCard(
              name: "Aya Omar",
              status: "Expired",
              statusColor: Color(0xFFD65C5C),
              buttonText: "Invite by Email",
            ),

            const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                "Pending Invites",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),

            const InviteCard(
              name: "Khaled Hamdy",
              status: "Pending",
              statusColor: Color(0xFFE8D95B),
              subText: "Invitation expires in 4 days",
              buttonVisible: false,
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
                    },
                  ),
                  _NavItem(
                    Icon: "assets/Home_admin/SVG_Icon/Email.svg",
                    label: 'Invites',
                    isActive: _selectedIndex == 1,
                    onTap: () => _onNavTap(1),
                  ),
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

// ================== Invite Card ==================

class InviteCard extends StatelessWidget {
  final String name;
  final String status;
  final Color statusColor;
  final String? subText;
  final String? buttonText;
  final bool buttonVisible;

  const InviteCard({
    super.key,
    required this.name,
    required this.status,
    required this.statusColor,
    this.subText,
    this.buttonText,
    this.buttonVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF151928),
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins"),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        status,
                        style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            if (subText != null) ...[
              const SizedBox(height: 6),
              Text(
                subText!,
                style: const TextStyle(
                    color: Colors.white60, fontSize: 12, fontFamily: "Poppins"),
              ),
            ],

            if (buttonVisible) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 13.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7EE3FF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      buttonText ?? "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: "Poppins"),
                    ),
                  ),
                ),
              ),
            ],
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
