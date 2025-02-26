import 'dart:convert';

import 'package:dio/dio.dart';

class ClientService {
  ClientService();

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> get(
      String url, Map<String, String> headers) async {
    try {
      final response = await _dio.get(url, options: Options(headers: headers));
      return jsonDecode(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
