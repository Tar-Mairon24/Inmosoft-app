import 'package:dio/dio.dart';
import 'package:frontend/domain/models/contrato_modelo.dart';
import 'package:logger/logger.dart';

class Result<T> {
  final bool success;
  final T? data;
  final String? errorMessage;

  Result({required this.success, this.data, this.errorMessage});
}

class ContratoService {
  final Dio _dio = Dio();
  final Logger log = Logger();

  // Obtener un contrato por ID
  Future<Result<Contrato>> getContrato(int idContrato) async {
    String? errorMessage;
    try {
      final response =
          await _dio.get('http://localhost:8080/contratos/$idContrato');
      if (response.statusCode == 200) {
        log.i('Contrato fetched successfully');
        final contrato = Contrato.fromJson(response.data);
        return Result(success: true, data: contrato);
      } else {
        errorMessage = 'Failed to get contrato: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } on DioException catch (e) {
      errorMessage = _handleDioError(e);
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    } catch (e) {
      errorMessage = 'Unexpected error: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  Future<Result<List<ContratoMenu>>> getAllContratos() async {
    String? errorMessage;
    try {
      final response = await _dio.get('http://localhost:8080/all/contratos');
      if (response.statusCode == 200) {
        log.i('Contratos fetched successfully');

        // Parse the data (make sure it matches the expected structure)
        final contratos = (response.data as List)
            .map((json) => ContratoMenu.fromJson(json))
            .toList();

        return Result(success: true, data: contratos);
      } else {
        errorMessage =
            'Failed to get contratos for propiedad: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } on DioException catch (e) {
      errorMessage = _handleDioError(e);
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    } catch (e) {
      errorMessage = 'Unexpected error: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  // Obtener contratos por propiedad
  Future<Result<List<dynamic>>> getContratosByPropiedad(int idPropiedad) async {
    String? errorMessage;
    try {
      final response = await _dio
          .get('http://localhost:8080/contratos/propiedad/$idPropiedad');
      if (response.statusCode == 200) {
        log.i('Contratos fetched successfully');
        return Result(success: true, data: response.data);
      } else {
        errorMessage =
            'Failed to get contratos for propiedad: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } on DioException catch (e) {
      errorMessage = _handleDioError(e);
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    } catch (e) {
      errorMessage = 'Unexpected error: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  // Crear un contrato
  Future<Result<void>> createContrato(Contrato contrato) async {
    String? errorMessage;
    log.w(contrato.toJson());
    try {
      final response = await _dio.post('http://localhost:8080/contratos',
          data: contrato.toJson());
      if (response.statusCode == 201) {
        log.i('Contrato created successfully');
        return Result(success: true);
      } else {
        errorMessage = 'Failed to create contrato: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } on DioException catch (e) {
      errorMessage = _handleDioError(e);
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    } catch (e) {
      errorMessage = 'Unexpected error: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  // Actualizar un contrato
  Future<Result<void>> updateContrato(Contrato contrato, int idContrato) async {
    String? errorMessage;
    try {
      log.w(contrato.toJson());
      final response = await _dio.put(
        'http://localhost:8080/contratos/$idContrato',
        data: contrato.toJson(),
      );
      if (response.statusCode == 200) {
        log.i('Contrato updated successfully');
        return Result(success: true);
      } else {
        errorMessage = 'Failed to update contrato: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } on DioException catch (e) {
      errorMessage = _handleDioError(e);
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    } catch (e) {
      errorMessage = 'Unexpected error: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  // Eliminar un contrato
  Future<Result<void>> deleteContrato(int idContrato) async {
    String? errorMessage;
    try {
      final response =
          await _dio.delete('http://localhost:8080/contratos/$idContrato');
      if (response.statusCode == 200) {
        log.i('Contrato deleted successfully');
        return Result(success: true);
      } else {
        errorMessage = 'Failed to delete contrato: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } on DioException catch (e) {
      errorMessage = _handleDioError(e);
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    } catch (e) {
      errorMessage = 'Unexpected error: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  String _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection Timeout Exception';
    } else if (e.type == DioExceptionType.sendTimeout) {
      return 'Send Timeout Exception';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Receive Timeout Exception';
    } else if (e.type == DioExceptionType.badResponse) {
      return 'Invalid status code: ${e.response?.statusCode}';
    } else if (e.type == DioExceptionType.cancel) {
      return 'Request was cancelled';
    } else {
      return 'Unexpected error: ${e.message}';
    }
  }
}
