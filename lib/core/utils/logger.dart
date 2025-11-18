import 'package:logger/logger.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: false,
    printEmojis: true,
    printTime: true,
  ),
);

void logInfo(String message) => logger.i(message);

void logWarning(String message) => logger.w(message);

void logError(String message, [dynamic error, StackTrace? stackTrace]) => logger.e(message, error, stackTrace);
