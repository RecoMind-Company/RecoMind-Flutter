import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


// ================== Invite Card ==================

class InviteCard extends StatelessWidget {
  final String name;
  final String status;
  final Color statusColor;
  final String? subText;
  final String? buttonText;
  final bool buttonVisible;
  final Function() ontap;
  const InviteCard({
    super.key,
    required this.name,
    required this.status,
    required this.statusColor,
    this.subText,
    this.buttonText,
    this.buttonVisible = true,
    required this.ontap
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
                customText(
                  text: name,
                      color: Colors.white,
                      textsize: 15,
                      fontweight: FontWeight.w500,
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
                      Gap(6),
                      customText(
                       text:status,
                            color: statusColor,
                            textsize: 12,
                            fontweight: FontWeight.w500),
                    ],
                  ),
                ),
              ],
            ),

            if (subText != null) ...[
              const SizedBox(height: 6),
              customText(
                text:subText!,
                    color: Colors.white60, textsize: 12
              ),
            ],

            if (buttonVisible) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 13.0),
                  child: ElevatedButton(
                    onPressed: ontap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7EE3FF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                    ),
                    child: customText(
                     text: buttonText ?? "",
                          color: Colors.black,
                          fontweight: FontWeight.bold,
                          textsize: 14,
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