import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ml_text_recognition/widgets/text_detector_painter.dart';
import 'package:ml_text_recognition/utils/image_utils.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    required this.imagePath,
    this.boxes,
    this.blockBoxes,
  });

  final String? imagePath;
  final List<Rect>? boxes;
  final List<Rect>? blockBoxes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
        child: imagePath == null
          ? const Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 60,
                  color: Colors.black,
                ),
                SizedBox(height: 10),
                Text(
                  "Procesador de Recibos",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ))
          : FutureBuilder<Size>(
              future: getImageSize(imagePath!),
              builder: (context, snap) {
                final imgSize = snap.data ?? Size.zero;
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.file(
                        File(imagePath!),
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ),
                    if ((boxes != null && boxes!.isNotEmpty || (blockBoxes != null && blockBoxes!.isNotEmpty)) && imgSize != Size.zero)
                      Positioned.fill(
                        child: CustomPaint(
                          painter: TextDetectorPainter(
                            lineBoxes: boxes ?? const [],
                            blockBoxes: blockBoxes ?? const [],
                            imageSize: imgSize,
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
    );
  }
}
