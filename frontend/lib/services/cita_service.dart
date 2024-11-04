import 'package:dio/dio.dart';
import 'package:frontend/models/citas_modelo.dart';
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

  Future<Result<List<Cita>>> getAllCitasUser(int idUsuario) async {
    String? errorMessage;
    try {
      final response = await _dio.get('http://localhost:8080/all/citas:$idUsuario');
      if (response.statusCode == 200) {
        final List<dynamic> citas = response.data;
        log.i('Citas fetched successfully');
        return Result(
          success: true,
          data: citas
              .map((cita) => Cita.fromJson(cita))
              .toList(),
        );
      } else {
        errorMessage = 'Failed to get citas: ${response.statusCode}';
        log.w('Failed to get citas');
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
        errorMessage =
            'Received invalid status code: ${e.response?.statusCode}';
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

  Future <Result> getCita(int idCita) async {
    String? errorMessage;
    try {
      final response = await _dio.get('http://localhost:8080/cita:$idCita');
      if (response.statusCode == 200) {
        final dynamic cita = response.data;
        log.i('Cita fetched successfully');
        return Result(
          success: true,
          data: Cita.fromJson(cita),
        );
      } else {
        errorMessage = 'Failed to get cita: ${response.statusCode}';
        log.w('Failed to get cita');
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
        errorMessage =
            'Received invalid status code: ${e.response?.statusCode}';
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

  Future<Result> createCita(Cita cita) async {
    String? errorMessage;
    try {
      final response = await _dio.post('http://localhost:8080/create/cita', data: cita.toJson());
      if (response.statusCode == 201) {
        log.i('Cita created successfully');
        return Result(success: true);
      } else {
        errorMessage = 'Failed to create cita: ${response.statusCode}';
        log.w('Failed to create cita');
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
        errorMessage =
            'Received invalid status code: ${e.response?.statusCode}';
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

  Future<Result> updateCita(Cita cita) async {
    String? errorMessage;
    try {
      final response = await _dio.put('http://localhost:8080/update/cita', data: cita.toJson());
      if (response.statusCode == 200) {
        log.i('Cita updated successfully');
        return Result(success: true);
      } else {
        errorMessage = 'Failed to update cita: ${response.statusCode}';
        log.w('Failed to update cita');
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
        errorMessage =
            'Received invalid status code: ${e.response?.statusCode}';
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

  Future<Result> deleteCita(int idCita) async {
    String? errorMessage;
    try {
      final response = await _dio.delete('http://localhost:8080/delete/cita:$idCita');
      if (response.statusCode == 200) {
        log.i('Cita deleted successfully');
        return Result(success: true);
      } else {
        errorMessage = 'Failed to delete cita: ${response.statusCode}';
        log.w('Failed to delete cita');
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
        errorMessage =
            'Received invalid status code: ${e.response?.statusCode}';
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