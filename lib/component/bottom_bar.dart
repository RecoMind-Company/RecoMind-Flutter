import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    required this.Icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  final String Icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

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
              color: const Color(0xff7EE3FF),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}