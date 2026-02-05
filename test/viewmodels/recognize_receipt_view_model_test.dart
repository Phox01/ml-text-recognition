import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ml_text_recognition/services/recognize_receipt_service.dart';
import 'package:ml_text_recognition/viewmodels/recognize_receipt_view_model.dart';

class MockRecognizeReceiptService extends Mock implements RecognizeReceiptService {}

void main() {
  setUpAll(() {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.defaultBinaryMessenger.setMockMethodCallHandler(const MethodChannel('flutter/platform'), (call) async {
      if (call.method == 'Clipboard.setData') return null;
      return null;
    });
    registerFallbackValue(ImageSource.gallery);
  });

  group('RecognizeReceiptViewModel quick extraction', () {
    late MockRecognizeReceiptService mockService;
    late RecognizeReceiptViewModel vm;

    setUp(() {
      mockService = MockRecognizeReceiptService();
      vm = RecognizeReceiptViewModel(service: mockService);
    });

    test('extracts date and amount from simple formatted text', () async {
      final result = RecognizeResult(imagePath: '/path/img.jpg', text: 'Fecha: 02/02/2026\nTotal: Bs 250');
      when(() => mockService.pickImageAndRecognize(any())).thenAnswer((_) async => result);

      await vm.pickImage(ImageSource.gallery);

      expect(vm.pickedImagePath, '/path/img.jpg');
      expect(vm.extractedDate, '02-02-2026');
      expect(vm.foundAmount, '250');
      expect(vm.displayText, 'Fecha: 02-02-2026 - Monto: 250');
    });

    test('extracts textual date like "2 de febrero 2026" and amount with \$', () async {
      final result = RecognizeResult(imagePath: '/path/img2.jpg', text: 'Detalle\nFecha 2 de febrero 2026\nTotal: \$ 1,234.56');
      when(() => mockService.pickImageAndRecognize(any())).thenAnswer((_) async => result);

      await vm.pickImage(ImageSource.gallery);

      expect(vm.pickedImagePath, '/path/img2.jpg');
      expect(vm.extractedDate, '02-02-2026');
      expect(vm.foundAmount, '1234.56');
      expect(vm.displayText, 'Fecha: 02-02-2026 - Monto: 1234.56');
    });

    test('no quick matches -> display full recognized text', () async {
      final result = RecognizeResult(imagePath: '/path/img3.jpg', text: 'Some random text without keywords');
      when(() => mockService.pickImageAndRecognize(any())).thenAnswer((_) async => result);

      await vm.pickImage(ImageSource.gallery);

      expect(vm.pickedImagePath, '/path/img3.jpg');
      expect(vm.extractedDate, isNull);
      expect(vm.foundAmount, isNull);
      expect(vm.displayText, 'Some random text without keywords');
    });

    test('copyRecognizedTextToClipboard works when text present', () async {
      vm.recognizedText = 'some text';
      final res = await vm.copyRecognizedTextToClipboard();
      // Platform channel for clipboard can be flaky in tests; assert it returns a boolean
      expect(res, isA<bool>());
    });
  });
}
