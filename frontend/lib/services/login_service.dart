import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioService {
  final Dio _dio = Dio();
  final Logger log = Logger();

  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'http://localhost:8080/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        log.i('Login successful for email: $email');
        return true;
      } else {
        log.w('Login failed for email: $email');
        return false;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        log.e('Connection Timeout Exception');
      } else if (e.type == DioExceptionType.sendTimeout) {
        log.e('Send Timeout Exception');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        log.e('Receive Timeout Exception');
      } else if (e.type == DioExceptionType.badResponse) {
        log.e('Received invalid status code: ${e.response?.statusCode}');
      } else if (e.type == DioExceptionType.cancel) {
        log.e('Request to API server was cancelled');
      } else if (e.type == DioExceptionType.unknown) {
        log.e('Unexpected error: ${e.message}');
      }
      return false;
    } catch (e) {
      ('Unexpected error: $e');
      return false;
    }
  }
}
