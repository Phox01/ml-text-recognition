import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizeResult {
  final String? imagePath;
  final String text;

  RecognizeResult({required this.imagePath, required this.text});
}

class RecognizeReceiptService {
  final ImagePicker _picker;
  final TextRecognizer _textRecognizer;

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
    for (final block in recognisedText.blocks) {
      for (final line in block.lines) {
        buffer.writeln(line.text);
      }
    }

    return RecognizeResult(imagePath: pickedImage.path, text: buffer.toString());
  }

  Future<void> close() async {
    _textRecognizer.close();
  }
}
