import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../services/recognize_receipt_service.dart';

class RecognizeReceiptViewModel extends ChangeNotifier {
  final RecognizeReceiptService _service;

  RecognizeReceiptViewModel({RecognizeReceiptService? service}) : _service = service ?? RecognizeReceiptService();

  String? pickedImagePath;
  String recognizedText = '';
  String? extractedDate; // dd-MM-yyyy
  String? foundAmount; // numeric string like 250 or 250.00
  String displayText = ''; // what to show in the UI's Scrollbar SelectableText
  bool isRecognizing = false;

  Future<void> pickImage(ImageSource source) async {
    try {
      isRecognizing = true;
      notifyListeners();

      final result = await _service.pickImageAndRecognize(source);

      if (result != null) {
        pickedImagePath = result.imagePath;
        recognizedText = result.text;

        // First run a quick, inexpensive extraction that scans lines and
        // stops early when date and amount are found.
        final quick = _quickExtract(recognizedText);
        extractedDate = quick['date'] as String?;
        foundAmount = quick['amount'] as String?;

        // If quick extraction found something, compose a small display string
        // and avoid showing the full recognized text (faster for the user).
        if (extractedDate != null || foundAmount != null) {
          final parts = <String>[];
          if (extractedDate != null) parts.add('Fecha: $extractedDate');
          if (foundAmount != null) parts.add('Monto: $foundAmount');
          displayText = parts.join(' - ');
        } else {
          // Fallback: try a more thorough textual date parsing
          extractedDate = _extractDateFromText(recognizedText);
          displayText = recognizedText; // show full text if nothing specific found
        }
      } else {
        pickedImagePath = null;
        recognizedText = '';
        extractedDate = null;
        foundAmount = null;
        displayText = '';
      }
    } catch (e) {
      recognizedText = 'Error recognizing text: $e';
      extractedDate = null;
      foundAmount = null;
      displayText = recognizedText;
      if (kDebugMode) print(recognizedText);
    } finally {
      isRecognizing = false;
      notifyListeners();
    }
  }

  // Attempts to find a date in the recognized text related to the keyword "fecha"
  // or any common date pattern. Returns formatted date as dd-MM-yyyy or null.
  String? _extractDateFromText(String text) {
    if (text.isEmpty) return null;

    final lower = text.toLowerCase();
    final lines = lower.split(RegExp(r'\r?\n'));

    // Common Spanish month names mapping
    const months = {
      'enero': 1,
      'febrero': 2,
      'marzo': 3,
      'abril': 4,
      'mayo': 5,
      'junio': 6,
      'julio': 7,
      'agosto': 8,
      'septiembre': 9,
      'setiembre': 9,
      'octubre': 10,
      'noviembre': 11,
      'diciembre': 12,
    };

    // regex patterns
    final datePattern1 = RegExp(r"(\d{1,2}[\/\-]\d{1,2}[\/\-]\d{2,4})"); // 02/02/2026 or 2-2-2026
    final datePattern2 = RegExp(r"(\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})"); // 2026-02-02
    final fechaLinePattern = RegExp(r'fecha[:\s]*(.*)', caseSensitive: false);
    final textualPattern = RegExp(r"(\d{1,2})\s+de\s+([a-záéíóú]+)\s+(\d{4})", caseSensitive: false);

    // First, try lines containing the keyword 'fecha'
    for (final line in lines) {
      if (line.contains('fecha')) {
        final m = fechaLinePattern.firstMatch(line);
        final after = m != null ? m.group(1)?.trim() ?? '' : '';
        if (after.isNotEmpty) {
          // Try numeric date
          final d1 = datePattern1.firstMatch(after);
          if (d1 != null) return _formatFromMatch(d1.group(1)!);

          final d2 = datePattern2.firstMatch(after);
          if (d2 != null) return _formatFromMatch(d2.group(1)!);

          // Try textual day '2 de febrero 2026'
          final tx = textualPattern.firstMatch(after);
          if (tx != null) {
            final day = int.tryParse(tx.group(1) ?? '');
            final monthName = tx.group(2) ?? '';
            final year = int.tryParse(tx.group(3) ?? '');
            final month = months[monthName.toLowerCase()];
            if (day != null && month != null && year != null) {
              return DateFormat('dd-MM-yyyy').format(DateTime(year, month, day));
            }
          }

          // If none matched, try to find any date inside 'after'
          final any = RegExp(r"(\d{1,2}[\/\-]\d{1,2}[\/\-]\d{2,4})").firstMatch(after);
          if (any != null) return _formatFromMatch(any.group(1)!);
        }
      }
    }

    // If not found via 'fecha', try to find a general date anywhere
    final any1 = datePattern1.firstMatch(lower);
    if (any1 != null) return _formatFromMatch(any1.group(1)!);

    final any2 = datePattern2.firstMatch(lower);
    if (any2 != null) return _formatFromMatch(any2.group(1)!);

    final tx2 = textualPattern.firstMatch(lower);
    if (tx2 != null) {
      final day = int.tryParse(tx2.group(1) ?? '');
      final monthName = tx2.group(2) ?? '';
      final year = int.tryParse(tx2.group(3) ?? '');
      final month = months[monthName.toLowerCase()];
      if (day != null && month != null && year != null) {
        return DateFormat('dd-MM-yyyy').format(DateTime(year, month, day));
      }
    }

    return null;
  }

  String? _formatFromMatch(String raw) {
    final cleaned = raw.replaceAll('\\', '/');
    try {
      // normalize separators
      final parts = cleaned.contains('/') ? cleaned.split('/') : cleaned.split('-');
      if (parts.length == 3) {
        // try dd/mm/yyyy or yyyy/mm/dd
        if (parts[0].length == 4) {
          final year = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final day = int.parse(parts[2]);
          return DateFormat('dd-MM-yyyy').format(DateTime(year, month, day));
        } else {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          return DateFormat('dd-MM-yyyy').format(DateTime(year, month, day));
        }
      }
    } catch (e) {
      if (kDebugMode) print('Date parse error: $e');
    }
    return null;
  }

  /// Quick, low-cost line-by-line scan to find "fecha" and "monto/total" values.
  /// Returns a map with optional 'date' and 'amount' keys.
  Map<String, String?> _quickExtract(String text) {
    String? date;
    String? amount;

    final lower = text.toLowerCase();
    final lines = lower.split(RegExp(r'\r?\n'));

    final simpleDate = RegExp(r"\d{1,2}[\/\-]\d{1,2}[\/\-]\d{2,4}");
    final amountPattern = RegExp(r"(bs\s*|bs\.|\$|s/|s\$)?\s*([\d.,]+)");

    final textualPattern = RegExp(r"(\d{1,2})\s+de\s+([a-záéíóú]+)\s+(\d{4})", caseSensitive: false);

    for (final line in lines) {
      if (date != null && amount != null) break; // stop early

      if (date == null && line.contains('fecha')) {
        // Take the substring after 'fecha' and look for simple date pattern
        final idx = line.indexOf('fecha');
        final after = line.substring(idx + 'fecha'.length).trim();
        final m = simpleDate.firstMatch(after);
        if (m != null) {
          date = _formatFromMatch(m.group(0)!);
        } else {
          // try textual '2 de febrero 2026' quickly
          final tx = textualPattern.firstMatch(after);
          if (tx != null) {
            final day = int.tryParse(tx.group(1) ?? '');
            final monthName = tx.group(2) ?? '';
            final year = int.tryParse(tx.group(3) ?? '');
            const months = {
              'enero': 1,
              'febrero': 2,
              'marzo': 3,
              'abril': 4,
              'mayo': 5,
              'junio': 6,
              'julio': 7,
              'agosto': 8,
              'septiembre': 9,
              'setiembre': 9,
              'octubre': 10,
              'noviembre': 11,
              'diciembre': 12,
            };
            final month = months[monthName.toLowerCase()];
            if (day != null && month != null && year != null) {
              date = DateFormat('dd-MM-yyyy').format(DateTime(year, month, day));
            }
          } else {
            // try numeric anywhere in the line
            final m2 = simpleDate.firstMatch(line);
            if (m2 != null) date = _formatFromMatch(m2.group(0)!);
          }
        }
      }

      if (amount == null && (line.contains('monto') || line.contains('total'))) {
        final idxMonto = line.indexOf('monto');
        final idxTotal = line.indexOf('total');
        final startIdx = (idxMonto >= 0) ? idxMonto + 5 : (idxTotal >= 0 ? idxTotal + 5 : 0);
        final after = line.substring(startIdx).trim();
        final m = amountPattern.firstMatch(after);
        if (m != null) {
          amount = _normalizeAmount(m.group(2) ?? '');
        } else {
          // fallback: any number in the line
          final any = RegExp(r"[\d]+[\.,]?\d*").firstMatch(line);
          if (any != null) amount = _normalizeAmount(any.group(0)!);
        }
      }
    }

    return {'date': date, 'amount': amount};
  }

  String _normalizeAmount(String raw) {
    // remove currency symbols and spaces
    var s = raw.replaceAll(RegExp(r"[^0-9.,]"), "");
    if (s.contains('.') && s.contains(',')) {
      // decide which is decimal by the last occurrence
      if (s.lastIndexOf('.') > s.lastIndexOf(',')) {
        // '.' is decimal, remove commas
        s = s.replaceAll(',', '');
      } else {
        // ',' is decimal, remove dots and replace comma with dot
        s = s.replaceAll('.', '');
        s = s.replaceAll(',', '.');
      }
    } else if (s.contains(',')) {
      s = s.replaceAll(',', '.');
    }
    return s;
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
    _service.close();
    super.dispose();
  }
}
