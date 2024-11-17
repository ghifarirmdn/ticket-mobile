import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ticket_mobile/models/ticket_model.dart';
import 'package:ticket_mobile/service/dio_client.dart';

abstract class TicketRepository {
  Future<List<TicketModel>?> getTickets();
  Future<Response> updateTicket({
    required int id,
    required String status,
  });
  Future<Response> addTicket({
    required String name,
    required String status,
  });
}

class TicketRepositoryImpl implements TicketRepository {
  @override
  Future<List<TicketModel>?> getTickets() async {
    final dio = await DioClient.getDioInstance();

    try {
      final response = await dio.get('/tickets');
      log('Successfully get tickets: ${response.data}');
      return (response.data as List)
          .map((e) => TicketModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      log('Error get tickets: ${e.response?.data ?? e.message}');
    }
    return null;
  }

  @override
  Future<Response> updateTicket({
    required int id,
    required String status,
  }) async {
    final dio = await DioClient.getDioInstance();

    Map<String, dynamic> data = {
      'status': status,
    };

    try {
      final response = await dio.post('/tickets/$id/update', data: data);
      log('Successfully update ticket: ${response.data}');
      return response;
    } on DioException catch (e) {
      log('Error update ticket: ${e.response?.data ?? e.message}');
      return e.response!;
    }
  }

  @override
  Future<Response> addTicket({
    required String name,
    required String status,
  }) async {
    final dio = await DioClient.getDioInstance();

    Map<String, dynamic> data = {
      'name': name,
      'status': status,
    };

    try {
      final response = await dio.post('/tickets', data: data);
      log('Successfully add ticket: ${response.data}');
      return response;
    } on DioException catch (e) {
      log('Error add ticket: ${e.response?.data ?? e.message}');
      return e.response!;
    }
  }
}
