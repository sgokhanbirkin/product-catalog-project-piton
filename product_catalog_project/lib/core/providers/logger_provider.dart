import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/service/logger_service.dart';

final loggerServiceProvider = Provider<LoggerService>((ref) {
  return LoggerService();
});
