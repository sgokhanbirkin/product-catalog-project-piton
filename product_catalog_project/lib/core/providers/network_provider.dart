import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/providers/auth_service_provider.dart';
import 'package:product_catalog_project/core/providers/logger_provider.dart';
import 'package:product_catalog_project/core/service/logging_interceptor.dart';
import 'package:product_catalog_project/core/service/project_network_manager.dart';

final projectNetworkManagerProvider = Provider<ProjectNetworkManager>((ref) {
  final authService = ref.watch(authServiceProvider);
  final loggingInterceptor = ref.watch(loggingInterceptorProvider);
  return ProjectNetworkManager(authService, loggingInterceptor);
});

final loggingInterceptorProvider = Provider<LoggingInterceptor>((ref) {
  final loggerService = ref.watch(loggerServiceProvider);
  return LoggingInterceptor(loggerService);
});
