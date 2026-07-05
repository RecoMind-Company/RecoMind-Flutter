import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class Listwid extends StatefulWidget {
  final bool selectall;
  final String tableName;
  final String tableDesc;
  final bool isSelected; // ✨ لمعرفة هل الكارد ده محدد حالياً أم لا
  final ValueChanged<bool> onSelectedChanged; // ✨ كول باك يبلغ الشاشة بالتغيير

  const Listwid({
    super.key,
    required this.selectall,
    required this.tableName,
    required this.tableDesc,
    required this.isSelected,
    required this.onSelectedChanged,
  });

  @override
  State<Listwid> createState() => _ListwidState();
}

class _ListwidState extends State<Listwid> {
  @override
  Widget build(BuildContext context) {
    // الكارد يكون أحمر لو عملنا Select All أو لو تم تحديده هو شخصياً
    final bool isCardRed = widget.selectall || widget.isSelected;

    return Column(
      children: [
        const Gap(12.5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF2B313E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCardRed ? Colors.redAccent : const Color(0xFF2B313E),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customText(
                        text: widget.tableName,
                        fontweight: FontWeight.w400,
                        textsize: 16,
                        color: Colors.white,
                      ),
                      const Gap(4),
                      const customText(
                        text: "Table Description",
                        fontweight: FontWeight.w500,
                        textsize: 9,
                        color: Color(0xFFACACAC),
                      ),
                      const Gap(4),
                      customText(
                        text: widget.tableDesc,
                        textsize: 11,
                        fontweight: FontWeight.w400,
                        color: const Color(0xFFE4E4E4),
                      ),
                    ],
                  ),
                ),
                const Gap(12),
                GestureDetector(
                  onTap: () {
                    // ✨ يبلغ الشاشة بعكس الحالة الحالية للكارد
                    widget.onSelectedChanged(!widget.isSelected);
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1F4FF),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isCardRed ? Colors.redAccent : const Color(0xFF2B313E),
                        width: 0.5,
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.minus,
                      color: isCardRed ? Colors.redAccent : const Color(0xFF2B313E),
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}