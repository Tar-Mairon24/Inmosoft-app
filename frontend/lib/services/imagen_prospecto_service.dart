import 'package:dio/dio.dart';
import 'package:frontend/domain/models/imagen_modelo.dart';
import 'package:frontend/domain/models/imagen_prospecto_modelo.dart';
import 'package:logger/logger.dart';

class Result<T> {
  final bool success;
  final T? data;
  final String? errorMessage;

  Result({required this.success, this.data, this.errorMessage});
}

class ImagenProspectoService {
  final Dio _dio = Dio();
  final Logger log = Logger();

  Future<Result<ImagenProspecto>> getImagen(int idImagen) async {
    String? errorMessage;
    try {
      final response =
          await _dio.get('http://localhost:8080/imagenes/$idImagen');
      if (response.statusCode == 200) {
        log.i('Imagen fetched successfully');
        return Result(
          success: true,
          data: ImagenProspecto.fromJson(response.data),
        );
      } else {
        errorMessage = 'Failed to fetch imagen: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } catch (e) {
      errorMessage = 'Error fetching imagen: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  Future<Result<ImagenProspecto>> getImagenPrincipal(int idProspecto) async {
    String? errorMessage;
    try {
      final response = await _dio.get(
          'http://localhost:8080/all/imagenesProspecto/principal/$idProspecto');
      if (response.statusCode == 200) {
        log.i('Imagen fetched successfully');
        return Result(
          success: true,
          data: ImagenProspecto.fromJson(response.data),
        );
      } else {
        errorMessage = 'Failed to fetch imagen: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } catch (e) {
      errorMessage = 'Error fetching imagen: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  Future<Result<List<ImagenProspecto>>> getImagenesByProspecto(
      int idProspecto) async {
    String? errorMessage;
    try {
      final response = await _dio
          .get('http://localhost:8080/all/imagenes/prospecto/$idProspecto');
      if (response.statusCode == 200) {
        log.i('Imagenes fetched successfully');
        final List<dynamic> data = response.data;
        return Result(
          success: true,
          data: data.map((item) => ImagenProspecto.fromJson(item)).toList(),
        );
      } else {
        errorMessage = 'Failed to fetch imagenes: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } catch (e) {
      errorMessage = 'Error fetching imagenes: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  Future<Result<int>> insertImagen(ImagenProspecto imagen) async {
    String? errorMessage;
    log.w(imagen.toJson());
    try {
      final response = await _dio.post(
        'http://localhost:8080/create/imagenProspecto',
        data: imagen.toJson(),
      );
      if (response.statusCode == 201) {
        log.i('Imagen created successfully');
        return Result(success: true);
      } else {
        errorMessage = 'Failed to create imagen: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } catch (e) {
      errorMessage = 'Error creating imagen: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }

  // Future<Result<void>> updateImagen(Imagen imagen, int idImagen) async {
  //   String? errorMessage;
  //   try {
  //     final response = await _dio.put(
  //       'http://localhost:8080/imagenes/$idImagen',
  //       data: imagen.toJson(),
  //     );
  //     if (response.statusCode == 200) {
  //       log.i('Imagen updated successfully');
  //       return Result(success: true);
  //     } else {
  //       errorMessage = 'Failed to update imagen: ${response.statusCode}';
  //       log.w(errorMessage);
  //       return Result(success: false, errorMessage: errorMessage);
  //     }
  //   } catch (e) {
  //     errorMessage = 'Error updating imagen: $e';
  //     log.e(errorMessage);
  //     return Result(success: false, errorMessage: errorMessage);
  //   }
  // }

  Future<Result<void>> deleteImagen(int idImagen) async {
    String? errorMessage;
    try {
      final response =
          await _dio.delete('http://localhost:8080/eliminar/imagen/$idImagen');
      if (response.statusCode == 200) {
        log.i('Imagen deleted successfully');
        return Result(success: true);
      } else {
        errorMessage = 'Failed to delete imagen: ${response.statusCode}';
        log.w(errorMessage);
        return Result(success: false, errorMessage: errorMessage);
      }
    } catch (e) {
      errorMessage = 'Error deleting imagen: $e';
      log.e(errorMessage);
      return Result(success: false, errorMessage: errorMessage);
    }
  }
}
