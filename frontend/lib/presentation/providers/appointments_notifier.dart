import 'package:flutter/material.dart';
import 'package:frontend/models/citas_modelo.dart';
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

  Future<Result<List<CitaMenu>>> loadData(int idUsuario, int mes) async {
    print("mes del notifier: ${mes}");
    return await citaService.getAllCitasUserMonth(idUsuario, mes);
  }

  void shouldRefresh() {
    notifyListeners();
  }
}
