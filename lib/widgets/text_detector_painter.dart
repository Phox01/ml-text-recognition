import 'package:flutter/material.dart';

class TextDetectorPainter extends CustomPainter {
  final List<Rect> lineBoxes;
  final List<Rect> blockBoxes;
  final Size imageSize;
  final BoxFit fit;
  final Alignment alignment;

  TextDetectorPainter({
    required this.lineBoxes,
    required this.blockBoxes,
    required this.imageSize,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (imageSize.width == 0 || imageSize.height == 0) return;

    final linePaint = Paint()
      ..color = Colors.redAccent.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final blockPaint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final FittedSizes fs = applyBoxFit(fit, imageSize, size);
    final Size destSize = fs.destination;

    final double dx = (size.width - destSize.width) * (alignment.x + 1) / 2;
    final double dy = (size.height - destSize.height) * (alignment.y + 1) / 2;

    final double scaleX = destSize.width / imageSize.width;
    final double scaleY = destSize.height / imageSize.height;

    for (final r in blockBoxes) {
      final mapped = Rect.fromLTWH(
        dx + r.left * scaleX,
        dy + r.top * scaleY,
        r.width * scaleX,
        r.height * scaleY,
      );
      canvas.drawRect(mapped, blockPaint);
    }

    for (final r in lineBoxes) {
      final mapped = Rect.fromLTWH(
        dx + r.left * scaleX,
        dy + r.top * scaleY,
        r.width * scaleX,
        r.height * scaleY,
      );
      canvas.drawRect(mapped, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
