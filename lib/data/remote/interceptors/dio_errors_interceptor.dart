import 'package:dio/dio.dart';
import 'package:recipes_test_task/core/utils/logger.dart';
import 'package:recipes_test_task/domain/errors/errors.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Errors error;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        error = const NetworkError();
        break;

      case DioExceptionType.badResponse:
        final status = err.response?.statusCode ?? 0;
        if (status == 404) {
          error = const NotFoundError();
        } else {
          error = ServerError(status);
        }
        break;

      case DioExceptionType.cancel:
        error = const UnknownError("Request was cancelled");
        break;

      case DioExceptionType.unknown:
      default:
        error = const UnknownError();
    }

    logger.e("DioException caught", err, err.stackTrace);

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: error,
        response: err.response,
        type: err.type,
        stackTrace: err.stackTrace,
      ),
    );
  }
}
