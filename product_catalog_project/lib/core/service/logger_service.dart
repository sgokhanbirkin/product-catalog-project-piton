// lib/core/service/logger_service.dart

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class LoggerService {
  final Logger logger;

  LoggerService()
      : logger = Logger(
          printer: PrettyPrinter(
            methodCount: 0,
            printEmojis: true,
            dateTimeFormat: (time) {
              return time.toString();
            },
          ),
        );
}
