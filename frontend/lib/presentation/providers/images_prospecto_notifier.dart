import 'package:flutter/material.dart';
import 'package:frontend/domain/models/imagen_prospecto_modelo.dart';
import 'package:frontend/services/imagen_prospecto_service.dart';

class ImagesProspectoNotifier with ChangeNotifier {
  late Future<List<ImagenProspecto>> _images;
  final ImagenProspectoService imagenService = ImagenProspectoService();

  Future<List<ImagenProspecto>> get images {
    return _images;
  }

  set images(Future<List<ImagenProspecto>> images) {
    _images = images;
    notifyListeners();
  }

  Future<Result<List<ImagenProspecto>>> loadData(int idProspecto) async {
    return await imagenService.getImagenesByProspecto(idProspecto);
  }

  void shouldRefresh() {
    notifyListeners();
  }
}
