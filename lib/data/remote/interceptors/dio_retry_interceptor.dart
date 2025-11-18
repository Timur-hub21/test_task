import 'dart:async';
import 'package:dio/dio.dart';

class DioRetryInterceptor extends Interceptor {
  final Dio dio;
  final int retries;
  final Duration retryDelay;

  DioRetryInterceptor({
    required this.dio,
    this.retries = 3,
    this.retryDelay = const Duration(seconds: 2),
  });

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    int attempt = 0;

    while (_shouldRetry(err) && attempt < retries) {
      attempt++;
      try {
        await Future.delayed(retryDelay);

        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        if (e is DioException) {
          err = e;
        } else {
          break;
        }
      }
    }

    return handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.unknown ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout;
  }
}
