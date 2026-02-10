import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml_text_recognition/image_preview.dart';
import 'package:ml_text_recognition/viewmodels/recognize_receipt_view_model.dart';
import 'package:ml_text_recognition/services/recognize_receipt_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RecognizeReceipt extends StatefulWidget {
  const RecognizeReceipt({super.key});
  @override
  State<RecognizeReceipt> createState() => _RecognizeReceiptState();
}

class _RecognizeReceiptState extends State<RecognizeReceipt> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _date = TextEditingController();
  String _startDate = '';
  String _description = '';
  String _category = '';
  late String dropdownValue = 'Business 1';
  // Controller handles picking and recognizing. Call it from the UI.

  void _chooseImageSourceModal(BuildContext rootContext, RecognizeReceiptViewModel ctl) {
    // Use the consumer's context so the BottomSheet is inserted under the same
    // widget tree where the Provider is available (prevents ProviderNotFoundException).
    showModalBottomSheet(
      context: rootContext,
      builder: (BuildContext sheetContext) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  ctl.pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a picture'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  ctl.pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _copyTextToClipboard(RecognizeReceiptViewModel ctl) async {
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
      create: (_) =>
          RecognizeReceiptViewModel(service: RecognizeReceiptService()),
      child: Consumer<RecognizeReceiptViewModel>(
        builder: (context, controller, _) {
          return Scaffold(
            appBar: AppBar(
                title: const Text('Recibo'),
                leading: IconButton(
                    icon: const Icon(Icons
                        .arrow_back), // Use arrow_forward for a right-pointing arrow
                    onPressed: () {
                      // Define the navigation logic (e.g., pop the current screen)
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    })),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ImagePreview(
                          imagePath: controller.pickedImagePath,
                          boxes: controller.recognizedBoxes,
                          blockBoxes: controller.recognizedBlockBoxes, //Basically this helps creating the boxes where I want
                        ),
                        Container(
                          height: 50,
                          color: Color.fromRGBO(9, 33, 98, 1),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: controller.isRecognizing
                                  ? null
                                  : () => _chooseImageSourceModal(context, controller),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(14, 49, 143, 1),
                                foregroundColor: Colors.black,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Escanear Recibo',
                                      style: TextStyle(color: Colors.white)),
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
                  Form(
                      key: _formKey,
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(children: [
                            Row(
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
                                  onPressed: () => _copyTextToClipboard(controller),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: _date,
                              decoration: const InputDecoration(
                                labelText: "Inicio",
                                hintText: "Seleccionar fecha",
                                filled: true,
                                prefixIcon: Icon(Icons.calendar_today),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor seleccione una fecha';
                                }
                                return null;
                              },
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));
                                if (pickedDate != null) {
                                  final formatted = DateFormat("dd-MM-yyyy")
                                      .format(pickedDate);
                                  _date.text = formatted;
                                  _startDate = formatted; // store string value
                                }
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingrese un título';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _description = value!;
                              },
                              decoration: const InputDecoration(
                                labelText: "Título del reporte",
                                hintText: "Escribir título del reporte",
                                filled: true,
                                prefixIcon: Icon(Icons.title),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<String>(
                              initialValue: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingrese un Centro de Costo';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _category = value!;
                              },
                              decoration: const InputDecoration(
                                labelText: "Centro de Costo",
                                hintText: "Escribir nombre del centro de costo",
                                filled: true,
                                prefixIcon: Icon(Icons.business_center),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: "Business 1",
                                  child: Text("Business 1"),
                                ),
                                DropdownMenuItem(
                                  value: "Business 2",
                                  child: Text("Business 2"),
                                ),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value ?? dropdownValue;
                                });
                              },
                            ),
                          ]))),
                  if (!controller.isRecognizing) ...[
                    Expanded(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Flexible(
                                child: SelectableText(
                                  controller.displayText.isNotEmpty
                                      ? controller.displayText
                                      : (controller.recognizedText.isEmpty ? "No text recognized" : controller.recognizedText),
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
