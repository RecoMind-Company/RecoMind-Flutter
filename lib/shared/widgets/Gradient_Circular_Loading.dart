import 'package:flutter/material.dart';
import 'dart:math' as math;

class SwappedShrinkingLoading extends StatefulWidget {
  final double size;
  final double strokeWidth;

  const SwappedShrinkingLoading({
    super.key,
    this.size = 100.0,
    this.strokeWidth = 8.0,
  });

  @override
  State<SwappedShrinkingLoading> createState() => _SwappedShrinkingLoadingState();
}

class _SwappedShrinkingLoadingState extends State<SwappedShrinkingLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationShift;
  late Animation<double> _animationRotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    // الانيميشن اللي بيتحكم في الطول (بيبدأ من الكبير للصغير)
    _animationShift = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: math.pi - 0.5, end: 0.2)
            .chain(CurveTween(curve: Curves.easeInOutQuart)),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.2, end: math.pi - 0.5)
            .chain(CurveTween(curve: Curves.easeInOutQuart)),
        weight: 50.0,
      ),
    ]).animate(_controller);

    _animationRotation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _SwappedPainter(
            shift: _animationShift.value,
            rotation: _animationRotation.value,
            strokeWidth: widget.strokeWidth,
          ),
        );
      },
    );
  }
}

class _SwappedPainter extends CustomPainter {
  final double shift;
  final double rotation;
  final double strokeWidth;

  _SwappedPainter({
    required this.shift,
    required this.rotation,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    const double fixedGap = 0.4; // المسافة الثابتة بين اللونين
    const double totalCircle = 2 * math.pi;

    // --- عكس الأدوار هنا ---
    // السماوي هو اللي بياخد قيمة الـ shift المتغيرة (بيصغر ويكبر)
    double cyanLength = shift + math.pi/2;
    // الرصاصي بياخد باقي المساحة عشان يكمل الدائرة مع الحفاظ على الـ gap
    double grayLength = totalCircle - cyanLength;

    // 1. رسم الجزء السماوي الزاهي (الأساسي دلوقتي)
    final cyanPaint = Paint()
      ..color = const Color(0xFF76E4FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      rotation,
      cyanLength - fixedGap,
      false,
      cyanPaint,
    );

    // 2. رسم الجزء الرصاصي (اللافندر)
    final grayPaint = Paint()
      ..color = const Color(0xFFC0C0D8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // بيبدأ بالظبط بعد السماوي بمسافة ثابتة
    canvas.drawArc(
      rect,
      rotation + cyanLength,
      grayLength - fixedGap,
      false,
      grayPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SwappedPainter oldDelegate) => true;
}