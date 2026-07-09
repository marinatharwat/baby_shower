import 'package:flutter/material.dart';
import 'dart:math' as math;

class BuntingWidget extends StatelessWidget {
  final double width;
  const BuntingWidget({super.key, this.width = 310});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 52,
      child: CustomPaint(painter: _BuntingPainter()),
    );
  }
}

class _BuntingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cordPaint = Paint()
      ..color = const Color(0xFFB98F58)
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;

    // Draw curved string
    final path = Path();
    path.moveTo(6, 10);
    path.quadraticBezierTo(size.width / 2, size.height - 4, size.width - 6, 10);
    canvas.drawPath(path, cordPaint);

    // Triangle flags
    final flags = [
      (0.02, const Color(0xFFA8D4EC)),
      (0.14, const Color(0xFFEDD9AA)),
      (0.28, const Color(0xFFA8D4EC)),
      (0.42, const Color(0xFFFAF3E6)),
      (0.57, const Color(0xFFA8D4EC)),
      (0.72, const Color(0xFFEDD9AA)),
      (0.87, const Color(0xFFA8D4EC)),
    ];

    for (final (t, color) in flags) {
      final pt = _getPointOnCurve(size, t);
      final flagPaint = Paint()..color = color;
      final triPath = Path()
        ..moveTo(pt.dx - 8, pt.dy)
        ..lineTo(pt.dx + 8, pt.dy)
        ..lineTo(pt.dx, pt.dy + 20)
        ..close();
      canvas.drawPath(triPath, flagPaint);
    }
  }

  Offset _getPointOnCurve(Size size, double t) {
    const p0x = 6.0; const p0y = 10.0;
    final p1x = size.width / 2; const p1y = 48.0;
    final p2x = size.width - 6; const p2y = 10.0;
    final x = (1-t)*(1-t)*p0x + 2*(1-t)*t*p1x + t*t*p2x;
    final y = (1-t)*(1-t)*p0y + 2*(1-t)*t*p1y + t*t*p2y;
    return Offset(x, y);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
