import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter/material.dart';

class RecognizeResult {
  final String? imagePath;
  final String text;
  final List<String> lines; // per-line text (in order)
  final List<Rect> lineBoxes;
  final List<String> blockTexts; // per-block text
  final List<Rect> blockBoxes;
  final List<int> blockLineStart; // starting index of lines for each block
  final List<int> blockLineCount; // number of lines for each block

  RecognizeResult({
    required this.imagePath,
    required this.text,
    required this.lines,
    required this.lineBoxes,
    required this.blockTexts,
    required this.blockBoxes,
    required this.blockLineStart,
    required this.blockLineCount,
  });
}

class RecognizeReceiptService {
  final ImagePicker _picker;
  final TextRecognizer _textRecognizer;
  // boxes are captured per recognition operation

  RecognizeReceiptService({ImagePicker? picker, TextRecognizer? recognizer})
      : _picker = picker ?? ImagePicker(),
        _textRecognizer = recognizer ?? TextRecognizer(script: TextRecognitionScript.latin);

  /// Picks an image (gallery or camera) and returns a RecognizeResult with
  /// the file path (may be null) and the recognized text (empty string if none).
  Future<RecognizeResult?> pickImageAndRecognize(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    if (pickedImage == null) return null;

    final inputImage = InputImage.fromFilePath(pickedImage.path);
    final RecognizedText recognisedText = await _textRecognizer.processImage(inputImage);

    final buffer = StringBuffer();
    final lines = <String>[];
    final lineBoxes = <Rect>[];
    final blockTexts = <String>[];
    final blockBoxes = <Rect>[];
    final blockLineStart = <int>[];
    final blockLineCount = <int>[];

    var globalLineIndex = 0;
    for (final block in recognisedText.blocks) {
      final blockStart = globalLineIndex;
      final sb = StringBuffer();
      blockBoxes.add(block.boundingBox);
      for (final line in block.lines) {
        final textLine = line.text.trim();
        sb.writeln(textLine);
        lines.add(textLine);
        lineBoxes.add(line.boundingBox);
        globalLineIndex++;
      }
      final blockText = sb.toString().trim();
      blockTexts.add(blockText);
      blockLineStart.add(blockStart);
      blockLineCount.add(globalLineIndex - blockStart);
      buffer.write(blockText);
      buffer.write('\n');
    }

    return RecognizeResult(
      imagePath: pickedImage.path,
      text: buffer.toString(),
      lines: lines,
      lineBoxes: lineBoxes,
      blockTexts: blockTexts,
      blockBoxes: blockBoxes,
      blockLineStart: blockLineStart,
      blockLineCount: blockLineCount,
    );
  }

  Future<void> close() async {
    _textRecognizer.close();
  }
}
