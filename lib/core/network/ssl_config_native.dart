import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

// Bypasses SSL certificate verification on native platforms (Android/iOS/desktop)
// in debug mode — needed when a VPN or proxy performs SSL inspection.
void configureSslBypass(Dio dio) {
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
      HttpClient()..badCertificateCallback = (_, __, ___) => true;
}
