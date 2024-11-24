import 'package:flutter/material.dart';
import 'package:frontend/domain/models/citas_modelo.dart';
import 'package:frontend/services/cita_service.dart';

class AppointmentsNotifier with ChangeNotifier {
  late Future<List<CitaMenu>> _appointments;
  final CitaService citaService = CitaService();

  Future<List<CitaMenu>> get appointments {
    return _appointments;
  }

  set appointments(Future<List<CitaMenu>> appointments) {
    this._appointments = appointments;
    notifyListeners();
  }

  Future<Result<List<CitaMenu>>> loadData(String idUsuario) async {
    return await citaService.getAllCitasUser(idUsuario);
  }

  Future<Result<List<CitaMenu>>> loadDataByDate(
      String idUsuario, String date) async {
    final result = await citaService.getAllCitasUserDay(idUsuario, date);

    // Si el resultado o los datos son null, retorna un objeto Result con una lista vacía.
    if (result.data == null) {
      return Result(success: true, data: []);
    }

    return result;
  }

  void shouldRefresh() {
    notifyListeners();
  }
}
