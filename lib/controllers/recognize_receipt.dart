export '../viewmodels/recognize_receipt_view_model.dart';

// Legacy compatibility: provide old name for a short migration period.
// Consumers importing from controllers/recognize_receipt.dart can keep using
// `RecognizeReceiptController` as an alias to the new ViewModel.

import '../viewmodels/recognize_receipt_view_model.dart';
import '../services/recognize_receipt_service.dart';

class RecognizeReceiptController extends RecognizeReceiptViewModel {
  RecognizeReceiptController({super.service});
}

