import 'package:flutter/material.dart';

class ConnectingLinesPainter extends CustomPainter {
  final List<Offset> circleOffsets;

  ConnectingLinesPainter(this.circleOffsets);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;
    if (circleOffsets.isNotEmpty) {
      for (int i = 0; i < circleOffsets.length; i++) {
        if (i == 1) {
          break;
        }
        canvas.drawLine(circleOffsets[i], circleOffsets[i + 1], paint);
      }

      for (final offset in circleOffsets) {
        canvas.drawCircle(offset, 5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
