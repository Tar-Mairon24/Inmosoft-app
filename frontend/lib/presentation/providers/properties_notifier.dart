import 'package:flutter/material.dart';
import 'package:frontend/models/propiedad_modelo.dart';
import 'package:frontend/services/propiedad_service.dart';
import 'package:stronglog/domain/models/day.dart';
import 'package:stronglog/infrastructure/stronglog_database.dart';

class PropertiesNotifier with ChangeNotifier {
  late Future<List<Propiedad>> _properties;
  final PropiedadService propiedadService = PropiedadService();

  Future<List<Propiedad>> get property {
    return _properties;
  }

  set days(Future<List<Propiedad>> properties) {
    this._properties = properties;
    notifyListeners();
  }

  Future<Result<List<Propiedad>>> loadData() async {
    return await propiedadService.getAllPropiedades();
  }

  void shouldRefresh() {
    notifyListeners();
  }
}
