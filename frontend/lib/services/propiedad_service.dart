import 'package:dio/dio.dart';
import 'package:frontend/domain/models/estado_propiedad_modelo.dart';
import 'package:frontend/domain/models/propiedad_menu_modelo.dart';
import 'package:frontend/domain/models/propiedad_modelo.dart';
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

  // Método para obtener todas las propiedades
  Future<Result<List<PropiedadMenu>>> getAllPropiedades() async {
    String? errorMessage;
    try {
      final response = await _dio.get('http://localhost:8080/all/propiedades');
      if (response.statusCode == 200) {
        final List<dynamic> propiedades = response.data;
        log.i('Propiedades fetched successfully');
        return Result(
          success: true,
          data: propiedades
              .map((propiedad) => PropiedadMenu.fromJson(propiedad))
              .toList(),
        );
      } else {
        errorMessage = 'Failed to get propiedades: ${response.statusCode}';
        log.w('Failed to get propiedades');
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

  Future<Result<List<PropiedadMenu>>> getAllPropiedadesByPrice() async {
    String? errorMessage;
    try {
      final response = await _dio.get('http://localhost:8080/all/propiedades');
      if (response.statusCode == 200) {
        final List<dynamic> propiedades = response.data;
        log.i('Propiedades fetched successfully');
        return Result(
          success: true,
          data: propiedades
              .map((propiedad) => PropiedadMenu.fromJson(propiedad))
              .toList(),
        );
      } else {
        errorMessage = 'Failed to get propiedades: ${response.statusCode}';
        log.w('Failed to get propiedades');
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

  Future<Result<List<PropiedadMenu>>> getAllPropiedadesByBedrooms() async {
    String? errorMessage;
    try {
      final response = await _dio.get('http://localhost:8080/all/propiedades');
      if (response.statusCode == 200) {
        final List<dynamic> propiedades = response.data;
        log.i('Propiedades fetched successfully');
        return Result(
          success: true,
          data: propiedades
              .map((propiedad) => PropiedadMenu.fromJson(propiedad))
              .toList(),
        );
      } else {
        errorMessage = 'Failed to get propiedades: ${response.statusCode}';
        log.w('Failed to get propiedades');
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

  // Método para obtener una propiedad por ID
  Future<Result<Propiedad>> getPropiedad(int idPropiedad) async {
    String? errorMessage;
    try {
      final response =
          await _dio.get('http://localhost:8080/propiedad/$idPropiedad');
      if (response.statusCode == 200) {
        final propiedad = Propiedad.fromJson(response.data);
        log.i('Propiedad fetched successfully');
        return Result(success: true, data: propiedad);
      } else {
        errorMessage = 'Failed to get propiedad: ${response.statusCode}';
        log.w('Failed to get propiedad');
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

  // Método para insertar una propiedad
  Future<void> insertPropiedad(
      Propiedad propiedad, EstadoPropiedad estadoPropiedad) async {
    try {
      final propiedadData = propiedad.toJson();
      final estadoPropiedadData = estadoPropiedad.toJson();
      log.w(propiedadData);
      log.w(estadoPropiedadData);
      log.w(estadoPropiedadData.toString());

      final response = await _dio.post(
        'http://localhost:8080/create/propiedad',
        data: {
          'propiedad': propiedadData,
          'estado_propiedad': estadoPropiedadData,
        },
      );

      if (response.statusCode == 200) {
        log.i('Propiedad y estado insertados correctamente');
      } else {
        log.w(
            'Error al insertar la propiedad y estado: ${response.statusCode}');
      }
    } catch (e) {
      log.e('Error al insertar propiedad y estado: $e');
    }
  }

  // Método para actualizar una propiedad
  Future<Result<void>> updatePropiedad(
      Propiedad propiedad, int idPropiedad) async {
    String? errorMessage;
    log.w(idPropiedad);
    try {
      final response = await _dio.put(
        'http://localhost:8080/update/propiedad/$idPropiedad',
        data: propiedad.toJson(),
      );
      if (response.statusCode == 200) {
        log.i('Propiedad updated successfully');
        return Result(success: true);
      } else {
        errorMessage = 'Failed to update propiedad: ${response.statusCode}';
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

  // Método para eliminar una propiedad
  Future<Result<void>> deletePropiedad(int idPropiedad) async {
    String? errorMessage;
    try {
      final response = await _dio.delete(
        'http://localhost:8080/eliminar/propiedad/$idPropiedad',
      );

      // Manejo de respuestas
      if (response.statusCode == 200) {
        log.i('Propiedad deleted successfully');
        return Result(success: true);
      } else {
        errorMessage = 'Failed to delete propiedad: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } on DioException catch (e) {
      errorMessage = _handleDioError(e);
      log.e('Dio error: $errorMessage');
      return Result(success: false, errorMessage: errorMessage);
    } catch (e) {
      errorMessage = 'Unexpected error: $e';
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
