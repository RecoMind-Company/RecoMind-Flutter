import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Listwid2 extends StatelessWidget {
  final bool selectall;
  final String tableName; // ✨ استقبال اسم الجدول الحقيقي
  final String tableDesc; // ✨ استقبال الوصف الحقيقي

  const Listwid2({
    super.key,
    required this.selectall,
    required this.tableName,
    required this.tableDesc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2638), // أو نفس لون الكارد عندك
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✨ عرض اسم الجدول القادم من البوستمان
                Text(
                  tableName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(6),
                // ✨ عرض الوصف القادم من البوستمان
                Text(
                  tableDesc,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          // هنا سيب كود الـ Checkbox أو الـ Icon المعتاد بتاعك زي ما هو...
        ],
      ),
    );
  }
}