import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dropdown extends StatefulWidget {
  final ValueNotifier<String?> selectedItem; // القيمة المختارة
  final String hints; // نص الهينت
  final TextEditingController controller; // من الخارج
  final List<String> items; // قائمة العناصر متغيرة

  Dropdown({
    super.key,
    required this.selectedItem,
    required this.hints,
    required this.controller,
    required this.items,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    // تعيين القيمة الافتراضية عند البداية
    if (widget.selectedItem.value != null) {
      widget.controller.text = widget.selectedItem.value!;
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _showOverlay(BuildContext context) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      return;
    }

    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5,
        width: size.width,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff212831),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.items.map((item) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.selectedItem.value = item;
                        widget.controller.text = item;
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: Text(
                          item,
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
              }).toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: widget.selectedItem,
      builder: (context, selectedCountryValue, child) {
        return Column(
          key: _key,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: widget.controller,
              onChanged: (val) {
                widget.selectedItem.value = val; // تحديث القيمة عند الكتابة
              },
              onTap: () => _showOverlay(context),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => _showOverlay(context),
                  icon: SvgPicture.asset("assets/down.svg"),
                ),
                hintText: widget.hints,
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
