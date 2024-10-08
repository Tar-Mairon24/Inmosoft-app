import 'package:dio/dio.dart';

class DioService {
  final Dio _dio = Dio();

  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'https://localhost:8080/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Assuming the API returns a success status
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}