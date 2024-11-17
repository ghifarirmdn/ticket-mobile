import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ticket_mobile/service/dio_client.dart';

abstract class AuthRepository {
  Future<Response> login({
    required String email,
    required String password,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    final dio = await DioClient.getDioInstance();

    Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    try {
      final response = await dio.post('/login', data: data);
      log('Successfully login: ${response.data}');
      return response;
    } on DioException catch (e) {
      log('Error login: ${e.response?.data ?? e.message}');
      return e.response!;
    }
  }
}
