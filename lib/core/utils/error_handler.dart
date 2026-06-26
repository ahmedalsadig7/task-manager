import 'package:dio/dio.dart';

String formatError(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Request timed out. Please check your connection and try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network and try again.';
      case DioExceptionType.badResponse:
        final code = error.response?.statusCode;
        if (code == 401) return 'Session expired. Please log in again.';
        if (code == 403) return 'You don\'t have permission to do that.';
        if (code == 404) return 'The requested resource was not found.';
        if (code != null && code >= 500) return 'Server error. Please try again later.';
        return 'Unexpected response from server. Please try again.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  final message = error.toString();

  // Pass through already user-friendly messages from repositories
  if (!message.startsWith('Exception:') &&
      !message.startsWith('DioException') &&
      !message.startsWith('type \'')) {
    return message;
  }

  // Strip "Exception: " prefix from throw Exception('...')
  if (message.startsWith('Exception: ')) {
    return message.replaceFirst('Exception: ', '');
  }

  return 'Something went wrong. Please try again.';
}
