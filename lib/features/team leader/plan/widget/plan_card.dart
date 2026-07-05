import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Widget buildPlanCard({
  required String title,
  required String goal,
  required List<String> actions,
  required bool isChecked,
  required Function(bool?) onCheckChanged,
  required Function(int) onDelete,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF151B29),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ✨ تعديل 1: تغليف الـ Column بـ Expanded لمنع الـ Goal والعنوان من الخروج عن الشاشة أفقياً بسبب الـ Checkbox المجاور
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                  const Gap(4),
                  Text(
                    "Goal: $goal",
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                    softWrap: true, // ✨ ينزل سطر تلقائياً إذا كان طويلاً
                  ),
                ],
              ),
            ),
            const Gap(10), // مسافة صغيرة تفصل النص عن الـ Checkbox
            Transform.scale(
              scale: 1.5,
              child: Checkbox(
                value: isChecked,
                onChanged: onCheckChanged,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Color(0xFFC0C0D8);
                  }
                  return const Color(0xFF333945);
                }),
                checkColor: Colors.greenAccent,
                side: const BorderSide(
                  color: Color(0xFF333945),
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            )
          ],
        ),
        const Gap(20),
        const Text(
          "Actions",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        const Gap(10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F2634),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              const Gap(10),
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: actions.length,
                separatorBuilder: (_, __) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Divider(
                    color: Colors.white10,
                    height: 1,
                    thickness: 1,
                  ),
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center, // لجعل زر الحذف يتوسط التكست لو نزل كذا سطر
                      children: [
                        // ✨ تعديل 2: تغليف نص الـ Action بـ Expanded ليجبر النص على احتلال المساحة المتبقية فقط والنزول لسطر جديد تلقائياً
                        Expanded(
                          child: Text(
                            actions[index],
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            softWrap: true, // ✨ النزول التلقائي للسطر الجديد
                          ),
                        ),
                        const Gap(15), // مسافة تفصل نص الأكشن عن زر الحذف
                        GestureDetector(
                          onTap: () => onDelete(index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE96666),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Color(0xFF1F2634),
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Divider(
                  color: Colors.white10,
                  height: 0.5,
                  thickness: 1,
                ),
              ),
              const Gap(20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Color(0xFF76E4FF), size: 20),
                  Gap(5),
                  Text(
                    "Add Action",
                    style: TextStyle(color: Color(0xFF76E4FF), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Gap(20)
            ],
          ),
        ),
      ],
    ),
  );
}