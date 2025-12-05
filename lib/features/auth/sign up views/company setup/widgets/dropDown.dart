import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:recomind/shared/widgets/custom_text.dart'; // نفترض أن هذه الودجت موجودة

class Dropdown extends StatefulWidget {
  Dropdown({super.key, required this.selectedCountry});
  // استخدام القيمة النهائية (final) في StatelessWidget أو جعلها قابلة للتعديل عبر الكلاس State
  final ValueNotifier<String?> selectedCountry;

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _key = GlobalKey(); // لتحديد موضع الـ TextField

  // قائمة الدول
  final List<String> countries = ['Egypt', 'UAE', 'England', 'Qatar'];

  @override
  void dispose() {
    _overlayEntry?.remove(); // إزالة الـ overlay عند حذف الودجت
    super.dispose();
  }

  void _showOverlay(BuildContext context) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      return; // إخفاء إذا كان مرئيًا بالفعل
    }

    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5.0, // تحت الـ TextField بمسافة 5 بكسل
        width: size.width,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff212831),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(countries.length, (index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // تحديث القيمة المختارة وإخفاء القائمة
                        widget.selectedCountry.value = countries[index];
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: Text( // استبدال customText بنص عادي للتجربة
                          countries[index],
                          style: const TextStyle(
                            color: Color(0xFFEEEEEE),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      height: 1,
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    // استخدم ValueListenableBuilder لمراقبة التغييرات في القيمة المختارة
    return ValueListenableBuilder<String?>(
      valueListenable: widget.selectedCountry,
      builder: (context, selectedCountryValue, child) {
        return Column(
          key: _key, // تعيين المفتاح لتحديد موضع الـ Overlay
          children: [
            TextField(
              readOnly: true, // لمنع الكتابة المباشرة
              onTap: () => _showOverlay(context), // فتح القائمة عند الضغط على الحقل
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => _showOverlay(context), // فتح القائمة عند الضغط على الأيقونة
                  icon: SvgPicture.asset("assets/down.svg"),
                ),
                hintText: selectedCountryValue ?? "Select a Country",
                hintStyle: const TextStyle(
                  color: Color(0xFFB8ADAD),
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffEFEFEF), width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffEFEFEF), width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              ),
            ),
          ],
        );
      },
    );
  }
}
