import 'package:recipes_test_task/core/utils/logger.dart';
import 'package:recipes_test_task/data/local/settings_local_data_source.dart';
import 'package:recipes_test_task/data/remote/interceptors/dio_retry_interceptor.dart';
import 'package:recipes_test_task/data/repository/settings_repository.dart';
import 'package:recipes_test_task/domain/repository/settings_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:recipes_test_task/core/env/env.dart';

part 'di.g.dart';

@riverpod
Dio dio(Ref ref) {
  ref.keepAlive();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Env().apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 7),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      compact: true,
      logPrint: (obj) => logger.i(obj.toString()),
    ),
  );

  dio.interceptors.add(
    DioRetryInterceptor(
      dio: dio,
      retries: 3,
      retryDelay: const Duration(seconds: 2),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (DioException err, handler) {
        logger.e('Request error: ${err.message}');
        handler.next(err);
      },
    ),
  );

  return dio;
}

@riverpod
SettingsLocalDataSource settingsLocalDataSource(Ref ref) {
  ref.keepAlive();
  return SettingsLocalDataSource();
}

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  final SettingsLocalDataSource settingsLocalDataSource = ref.watch(settingsLocalDataSourceProvider);
  return SettingsRepositoryImpl(settingsLocalDataSource);
}
