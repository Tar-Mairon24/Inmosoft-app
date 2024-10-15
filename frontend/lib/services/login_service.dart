import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoginReuslt {
  final bool success;
  final String? errorMessage;

  LoginReuslt({required this.success, this.errorMessage});
}

class DioService {
  final Dio _dio = Dio();
  final Logger log = Logger();

  Future<LoginReuslt> login(String email, String password) async {
    String? errorMessage;
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
        return LoginReuslt(success: true);
      } else {
        log.w('Login failed for email: $email');
        return LoginReuslt(success: false, errorMessage: 'Invalid credentials');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        log.e('Connection Timeout Exception');
        errorMessage = 'Connection Timeout Exception';
      } else if (e.type == DioExceptionType.sendTimeout) {
        log.e('Send Timeout Exception');
        errorMessage = 'Send Timeout Exception';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        log.e('Receive Timeout Exception');
        errorMessage = 'Receive Timeout Exception';
      } else if (e.type == DioExceptionType.badResponse) {
        log.e('Received invalid status code: ${e.response?.statusCode}');
        errorMessage = 'Received invalid status code: ${e.response?.statusCode}';
      } else if (e.type == DioExceptionType.cancel) {
        log.e('Request to API server was cancelled');
        errorMessage = 'Request to API server was cancelled';
      } else if (e.type == DioExceptionType.unknown) {
        log.e('Unexpected error: ${e.message}');
        errorMessage = 'Unexpected error: ${e.message}';
      }
      log.e('Error: $errorMessage');
      return LoginReuslt(success: false, errorMessage: errorMessage);
    } catch (e) {
      final errorMessage = 'Unexpected error: $e';
      return LoginReuslt(success: false, errorMessage: errorMessage);
    }
  }
}