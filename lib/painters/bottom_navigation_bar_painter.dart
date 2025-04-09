import 'package:flutter/material.dart';

class BottomNavigationBarPainter extends CustomPainter {

  final int selectedIndex;
  final IconData selectedIcon;

  BottomNavigationBarPainter({required this.selectedIndex, required this.selectedIcon});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 2
          ..style = PaintingStyle.fill;

    final path = Path();

    double w = size.width * ((selectedIndex * 0.4) + 0.2);
    double m = 100;
    double hm = m / 2 + 10;
    double h = size.height;

    path.moveTo(0, 0);

    path.lineTo(0, h);

    path.lineTo(size.width, h);

    path.lineTo(size.width, 0);

    path.lineTo((w / 2) + m, 0);

    path.quadraticBezierTo(w / 2 + hm, 0, w / 2 + 30, 30);

    path.quadraticBezierTo(w / 2, h / 2 + 25, w / 2 - 30, 30);

    path.quadraticBezierTo(w / 2 - hm, 0, w / 2 - m, 0);

    path.lineTo(0, 0);

    canvas.drawOval(
      Rect.fromCenter(center: Offset(w / 2, 5), width: 60, height: 60),
      paint,
    );


    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: String.fromCharCode(selectedIcon.codePoint),
      style: TextStyle(
        color: Colors.blue,
        fontSize: 40,
        fontFamily: selectedIcon.fontFamily,
        package: selectedIcon.fontPackage,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(w / 2 - 20, -15));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
