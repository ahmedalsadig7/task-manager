import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'ssl_config_stub.dart'
    if (dart.library.io) 'ssl_config_native.dart';

class AppHttpClient {
  AppHttpClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      ),
    );

    if (kDebugMode) {
      configureSslBypass(_dio);
    }
  }

  late final Dio _dio;

  Future<dynamic> get(String path, {Map<String, String>? queryParams}) async {
    final response = await _dio.get<dynamic>(path, queryParameters: queryParams);
    return response.data;
  }

  Future<dynamic> post(String path, {required Map<String, dynamic> body}) async {
    final response = await _dio.post<dynamic>(path, data: body);
    return response.data;
  }

  Future<dynamic> patch(String path, {required Map<String, dynamic> body}) async {
    final response = await _dio.patch<dynamic>(path, data: body);
    return response.data;
  }
}

class AppHttpException implements Exception {
  const AppHttpException(this.message, this.statusCode);
  final String message;
  final int statusCode;

  @override
  String toString() => message;
}
