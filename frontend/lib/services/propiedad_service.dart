import 'package:dio/dio.dart';
import 'package:frontend/models/propiedad_modelo.dart';
import 'package:logger/logger.dart';

class Result<T> {
  final bool success;
  final T? data;
  final String? errorMessage;

  Result({required this.success, this.data, this.errorMessage});
}

class PropiedadService {
  final Dio _dio = Dio();
  final Logger log = Logger();

  Future<Result<List<PropiedadMenu>>> getPropiedades() async {
    String? errorMessage;
    try {
      final response = await _dio.get('http://localhost:8080/all/propiedades');
      if (response.statusCode == 200) {
        final List<dynamic> propiedades = response.data;
        log.i('Propiedades fetched successfully');
        return Result(
          success: true,
          data: propiedades.map((propiedad) => PropiedadMenu.fromJson(propiedad)).toList(),
        );
      } else {
        errorMessage = 'Failed to get propiedades: ${response.statusCode}';
        log.w('Failed to get propiedades');
        return Result(success: false, errorMessage: errorMessage);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection Timeout Exception';
      } else if (e.type == DioExceptionType.sendTimeout) {
        errorMessage = 'Send Timeout Exception';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Receive Timeout Exception';
      } else if (e.type == DioExceptionType.badResponse) {
        errorMessage = 'Received invalid status code: ${e.response?.statusCode}';
      } else if (e.type == DioExceptionType.cancel) {
        errorMessage = 'Request to API server was cancelled';
      } else if (e.type == DioExceptionType.unknown) {
        errorMessage = 'Unexpected error: ${e.message}';
      } else {
        errorMessage = 'Unexpected error';
      }
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    } catch (e) {
      final errorMessage = 'Unexpected error: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }
}

