import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    required this.imagePath,
  });

  final String? imagePath;

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
          : Image.file(
              File(imagePath!),
              fit: BoxFit.contain,
            ),
    );
  }
}
