import 'package:dio/dio.dart';
import 'package:frontend/domain/models/estado_propiedad_modelo.dart';
import 'package:logger/logger.dart';

class Result<T> {
  final bool success;
  final T? data;
  final String? errorMessage;

  Result({required this.success, this.data, this.errorMessage});
}

class EstadoPropiedadService {
  final Dio _dio = Dio();
  final Logger log = Logger();

  // Método para obtener el estado de una propiedad por ID
  Future<Result<EstadoPropiedad?>> getEstadoPropiedad(
      int idTipoPropiedad) async {
    String? errorMessage;
    try {
      final response = await _dio
          .get('http://localhost:8080/estadoPropiedad/$idTipoPropiedad');
      if (response.statusCode == 200) {
        final estadoPropiedad = EstadoPropiedad.fromJson(response.data);
        log.i('Estado de propiedad fetched successfully');
        return Result(success: true, data: estadoPropiedad);
      } else {
        errorMessage =
            'Failed to get estado de propiedad: ${response.statusCode}';
        log.w('Failed to get estado de propiedad');
        return Result(success: false, errorMessage: errorMessage);
      }
    } on DioException catch (e) {
      errorMessage = _handleDioError(e);
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    } catch (e) {
      final errorMessage = 'Unexpected error: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  // Método para crear un nuevo estado de propiedad
  Future<Result<int>> createEstadoPropiedad(EstadoPropiedad estado) async {
    String? errorMessage;
    try {
      final response = await _dio.post('http://localhost:8080/estadoPropiedad',
          data: estado.toJson());
      if (response.statusCode == 200) {
        final newId = response.data['id_estado_propiedades'];
        log.i('Estado de propiedad created successfully');
        return Result(success: true, data: newId);
      } else {
        errorMessage =
            'Failed to create estado de propiedad: ${response.statusCode}';
        log.w('Failed to create estado de propiedad');
        return Result(success: false, errorMessage: errorMessage);
      }
    } on DioException catch (e) {
      errorMessage = _handleDioError(e);
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    } catch (e) {
      final errorMessage = 'Unexpected error: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  // Método para actualizar el estado de una propiedad
  // Future<Result<void>> updateEstadoPropiedad(EstadoPropiedad estado) async {
  //   String? errorMessage;
  //   try {
  //     final response = await _dio.put(
  //         'http://localhost:8080/estadoPropiedad/${estado.IDEstadoPropiedades}',
  //         data: estado.toJson());
  //     if (response.statusCode == 200) {
  //       log.i('Estado de propiedad updated successfully');
  //       return Result(success: true);
  //     } else {
  //       errorMessage =
  //           'Failed to update estado de propiedad: ${response.statusCode}';
  //       log.w(errorMessage);
  //       return Result(success: false, errorMessage: errorMessage);
  //     }
  //   } on DioException catch (e) {
  //     errorMessage = _handleDioError(e);
  //     log.e(errorMessage);
  //     return Result(success: false, errorMessage: errorMessage);
  //   } catch (e) {
  //     final errorMessage = 'Unexpected error: $e';
  //     log.e(errorMessage);
  //     return Result(success: false, errorMessage: errorMessage);
  //   }
  // }

  // Método para eliminar un estado de propiedad
  Future<Result<void>> deleteEstadoPropiedad(int idEstadoPropiedad) async {
    String? errorMessage;
    try {
      final response = await _dio.delete(
          'http://localhost:8080/eliminar/estadoPropiedad/$idEstadoPropiedad');
      if (response.statusCode == 200) {
        log.i('Estado de propiedad deleted successfully');
        return Result(success: true);
      } else {
        errorMessage =
            'Failed to delete estado de propiedad: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } on DioException catch (e) {
      errorMessage = _handleDioError(e);
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    } catch (e) {
      final errorMessage = 'Unexpected error: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  // Método auxiliar para manejar errores de Dio
  String _handleDioError(DioException e) {
    String errorMessage;
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
    return errorMessage;
  }
}
