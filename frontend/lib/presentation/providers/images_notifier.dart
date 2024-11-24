import 'package:flutter/material.dart';
import 'package:frontend/domain/models/imagen_modelo.dart';
import 'package:frontend/domain/models/propiedad_menu_modelo.dart';
import 'package:frontend/services/imagen_service.dart';

class ImagesNotifier with ChangeNotifier {
  late Future<List<Image>> _images;
  final ImagenService imagenService = ImagenService();

  Future<List<Image>> get images {
    return _images;
  }

  set images(Future<List<Image>> images) {
    _images = images;
    notifyListeners();
  }

  Future<Result<List<Imagen>>> loadData(int idPropiedad) async {
    return await imagenService.getImagenesByPropiedad(idPropiedad);
  }

  void shouldRefresh() {
    notifyListeners();
  }
}
