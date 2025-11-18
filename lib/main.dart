import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_test_task/application.dart';
import 'package:recipes_test_task/core/utils/logger.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        logger.e("FlutterError caught", details.exception, details.stack);
      };

      logger.i("INFO log before app starts");
      logger.w("WARNING log before app starts");
      logger.e("ERROR log before app starts", Exception("Test exception"));

      runApp(const ProviderScope(child: Application()));
    },
    (error, stackTrace) {
      logger.e("Uncaught error in runZonedGuarded", error, stackTrace);
    },
  );
}
