import 'package:flutter/material.dart';
import 'package:frontend/domain/models/contrato_modelo.dart';
import 'package:frontend/domain/models/propiedad_menu_modelo.dart';
import 'package:frontend/services/contrato_service.dart';

class AgreementsNotifier with ChangeNotifier {
  late Future<List<ContratoMenu>> _agreements;
  final ContratoService contratoService = ContratoService();

  Future<List<ContratoMenu>> get agreements {
    return _agreements;
  }

  set properties(Future<List<ContratoMenu>> agreements) {
    _agreements = agreements;
    notifyListeners();
  }

  Future<Result<List<ContratoMenu>>> loadData() async {
    return await contratoService.getAllContratos();
  }

  void shouldRefresh() {
    notifyListeners();
  }
}
