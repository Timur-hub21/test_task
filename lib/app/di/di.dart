import 'dart:convert';

import 'package:recipes_test_task/core/utils/logger.dart';
import 'package:recipes_test_task/data/local/recipes_local_data_source.dart';
import 'package:recipes_test_task/data/local/settings_local_data_source.dart';
import 'package:recipes_test_task/data/remote/interceptors/dio_retry_interceptor.dart';
import 'package:recipes_test_task/data/remote/recipes/recipes_remote_data_source.dart';
import 'package:recipes_test_task/data/repository/recipes_repository.dart';
import 'package:recipes_test_task/data/repository/settings_repository.dart';
import 'package:recipes_test_task/domain/repository/recipes_repository_impl.dart';
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
      responseType: ResponseType.plain,
    ),
  );

  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: false,
      compact: true,
      logPrint: (obj) => logger.i(obj.toString()),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onResponse:
          (
            Response<dynamic> response,
            ResponseInterceptorHandler handler,
          ) {
            dynamic data = response.data;

            if (data is String) {
              try {
                data = json.decode(data);
              } catch (e) {
                logger.w('Не удалось декодировать JSON');
              }
            }

            if (data is Map || data is List) {
              final String prettyData = const JsonEncoder.withIndent('  ').convert(data);
              logger.i('Response[${response.statusCode}] ${response.requestOptions.path}:\n$prettyData');
            } else {
              logger.i('Response[${response.statusCode}] ${response.requestOptions.path} (не JSON):\n$data');
            }
            response.data = data;
            handler.next(response);
          },
      onError: (DioException err, handler) {
        logger.e('Request error: ${err.message}');
        handler.next(err);
      },
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
RecipesLocalDataSource recipesLocalDataSource(Ref ref) {
  ref.keepAlive();
  return RecipesLocalDataSource();
}

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  final SettingsLocalDataSource settingsLocalDataSource = ref.watch(settingsLocalDataSourceProvider);
  return SettingsRepositoryImpl(settingsLocalDataSource);
}

@riverpod
RecipesRemoteDataSource recipesRemoteDataSource(Ref ref) {
  final Dio dio = ref.watch(dioProvider);
  return RecipesRemoteDataSourceImpl(dio: dio);
}

@riverpod
RecipesRepository recipesRepository(Ref ref) {
  final RecipesRemoteDataSource recipesRemoteDataSource = ref.watch(recipesRemoteDataSourceProvider);
  return RecipesRepositoryImpl(recipesRemoteDataSource: recipesRemoteDataSource);
}
