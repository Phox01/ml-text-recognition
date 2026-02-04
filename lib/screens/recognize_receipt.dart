import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml_text_recognition/image_preview.dart';
import 'package:ml_text_recognition/controllers/recognize_receipt.dart';
import 'package:provider/provider.dart';

class RecognizeReceipt extends StatefulWidget {
  const RecognizeReceipt({super.key});
  @override
  State<RecognizeReceipt> createState() => _RecognizeReceiptState();
}

class _RecognizeReceiptState extends State<RecognizeReceipt> {

  // Controller handles picking and recognizing. Call it from the UI.

  void _chooseImageSourceModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  final ctl = Provider.of<RecognizeReceiptController>(context, listen: false);
                  ctl.pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a picture'),
                onTap: () {
                  Navigator.pop(context);
                  final ctl = Provider.of<RecognizeReceiptController>(context, listen: false);
                  ctl.pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _copyTextToClipboard() async {
    final ctl = Provider.of<RecognizeReceiptController>(context, listen: false);
    final success = await ctl.copyRecognizedTextToClipboard();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'Text copied to clipboard' : 'No text to copy'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecognizeReceiptController(),
      child: Consumer<RecognizeReceiptController>(
        builder: (context, controller, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Recibo'),
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ImagePreview(imagePath: controller.pickedImagePath),
                        Container(
                          height: 50,
                          color: Color.fromRGBO(9, 33, 98, 1),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: controller.isRecognizing ? null : _chooseImageSourceModal,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(14, 49, 143, 1),
                                foregroundColor: Colors.black,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Pick an image', style: TextStyle(color: Colors.white)),
                                  if (controller.isRecognizing) ...[
                                    const SizedBox(width: 8),
                                    const SizedBox(
                                      width: 8,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.5,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recognized Text",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                            size: 16,
                          ),
                          onPressed: _copyTextToClipboard,
                        ),
                      ],
                    ),
                  ),
                  if (!controller.isRecognizing) ...[
                    Expanded(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Flexible(
                                child: SelectableText(
                                  controller.recognizedText.isEmpty
                                      ? "No text recognized"
                                      : controller.recognizedText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  
}
