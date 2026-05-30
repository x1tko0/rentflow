import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/billing_service.dart';

final proStatusProvider = FutureProvider<bool>((ref) {
  return BillingService.isPro();
});
