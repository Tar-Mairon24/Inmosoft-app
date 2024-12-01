import 'package:dio/dio.dart';
import 'package:frontend/domain/models/documento_anexo_modelo.dart';
import 'package:logger/logger.dart';

class Result<T> {
  final bool success;
  final T? data;
  final String? errorMessage;

  Result({required this.success, this.data, this.errorMessage});
}

class DocumentosAnexosService {
  final Dio _dio = Dio();
  final Logger log = Logger();

  Future<Result<DocumentoAnexo>> getDocumentoAnexo(int idDocumentoAnexo) async {
    String? errorMessage;
    try {
      final response = await _dio
          .get('http://localhost:8080/documento_anexo/$idDocumentoAnexo');
      if (response.statusCode == 200) {
        log.i('DocumentoAnexo fetched successfully');
        return Result(
          success: true,
          data: DocumentoAnexo.fromJson(response.data),
        );
      } else {
        errorMessage =
            'Failed to fetch documento anexo: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } catch (e) {
      errorMessage = 'Error fetching documento anexo: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  Future<Result<List<DocumentoAnexo>>> getDocumentosByPropiedad(
      int idPropiedad) async {
    String? errorMessage;
    try {
      final response = await _dio.get(
          'http://localhost:8080/all/documentos_anexos/propiedad/$idPropiedad');
      if (response.statusCode == 200) {
        log.i('DocumentosAnexos fetched successfully');
        final List<dynamic> data = response.data;
        return Result(
          success: true,
          data: data.map((item) => DocumentoAnexo.fromJson(item)).toList(),
        );
      } else {
        errorMessage =
            'Failed to fetch documentos anexos: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } catch (e) {
      errorMessage = 'Error fetching documentos anexos: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  Future<Result<int>> insertDocumentoAnexo(DocumentoAnexo documento) async {
    String? errorMessage;
    log.w(documento.toJson());
    try {
      final response = await _dio.post(
        'http://localhost:8080/create/documento_anexo',
        data: documento.toJson(),
      );
      if (response.statusCode == 201) {
        log.i('DocumentoAnexo created successfully');
        return Result(success: true);
      } else {
        errorMessage =
            'Failed to create documento anexo: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } catch (e) {
      errorMessage = 'Error creating documento anexo: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  Future<Result<void>> updateDocumentoAnexo(
      DocumentoAnexo documento, int idDocumentoAnexo) async {
    String? errorMessage;
    try {
      final response = await _dio.put(
        'http://localhost:8080/documentos_anexos/$idDocumentoAnexo',
        data: documento.toJson(),
      );
      if (response.statusCode == 200) {
        log.i('DocumentoAnexo updated successfully');
        return Result(success: true);
      } else {
        errorMessage =
            'Failed to update documento anexo: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } catch (e) {
      errorMessage = 'Error updating documento anexo: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  Future<Result<void>> deleteDocumentoAnexo(int idDocumentoAnexo) async {
    String? errorMessage;
    try {
      final response = await _dio.delete(
          'http://localhost:8080/eliminar/documento_anexo/$idDocumentoAnexo');
      if (response.statusCode == 200) {
        log.i('DocumentoAnexo deleted successfully');
        return Result(success: true);
      } else {
        errorMessage =
            'Failed to delete documento anexo: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } catch (e) {
      errorMessage = 'Error deleting documento anexo: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }
}
