import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizeReceiptController extends ChangeNotifier {
  final TextRecognizer textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);
  final ImagePicker imagePicker = ImagePicker();

  String? pickedImagePath;
  String recognizedText = '';
  bool isRecognizing = false;

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage == null) return;

    pickedImagePath = pickedImage.path;
    isRecognizing = true;
    notifyListeners();

    try {
      final inputImage = InputImage.fromFilePath(pickedImage.path);
      final RecognizedText recognisedText =
          await textRecognizer.processImage(inputImage);

      final buffer = StringBuffer();
      for (final block in recognisedText.blocks) {
        for (final line in block.lines) {
          buffer.writeln(line.text);
        }
      }
      recognizedText = buffer.toString();
    } catch (e) {
      recognizedText = 'Error recognizing text: $e';
      if (kDebugMode) {
        print(recognizedText);
      }
    } finally {
      isRecognizing = false;
      notifyListeners();
    }
  }

  Future<bool> copyRecognizedTextToClipboard() async {
    if (recognizedText.isEmpty) return false;
    try {
      await Clipboard.setData(ClipboardData(text: recognizedText));
      return true;
    } catch (e) {
      if (kDebugMode) print('Clipboard error: $e');
      return false;
    }
  }

  @override
  void dispose() {
    textRecognizer.close();
    super.dispose();
  }
}
