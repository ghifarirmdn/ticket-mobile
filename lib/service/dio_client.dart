import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_mobile/core/constants/url.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    // connectTimeout: const Duration(seconds: 30),
    // receiveTimeout: const Duration(seconds: 30),
  ));

  static Future<Dio> getDioInstance() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          log('Unauthorized. Redirect to login.');
        }
        return handler.next(e);
      },
    ));

    return _dio;
  }
}
