class Contrato {
  int idContrato;
  String tituloContrato;
  String? descripcionContrato;
  String? tipo;
  String? rutaPDF;
  int idPropiedad;

  Contrato({
    required this.idContrato,
    required this.tituloContrato,
    this.descripcionContrato,
    this.tipo,
    this.rutaPDF,
    required this.idPropiedad,
  });

  // Método para convertir un JSON a un objeto Contrato
  factory Contrato.fromJson(Map<String, dynamic> json) {
    return Contrato(
      idContrato: json['id_contrato'] as int,
      tituloContrato: json['titulo_contrato'] as String,
      descripcionContrato: json['descripcion_contrato'] as String?,
      tipo: json['tipo'] as String?,
      rutaPDF: json['ruta_pdf'] as String?,
      idPropiedad: json['id_propiedad'] as int,
    );
  }

  // Método para convertir un objeto Contrato a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_contrato': idContrato,
      'titulo_contrato': tituloContrato,
      'descripcion_contrato': descripcionContrato,
      'tipo': tipo,
      'ruta_pdf': rutaPDF,
      'id_propiedad': idPropiedad,
    };
  }
}

class ContratoMenu {
  int idContrato;
  String tituloContrato;
  String tipo;
  String tituloPropiedad;

  ContratoMenu({
    required this.idContrato,
    required this.tituloContrato,
    required this.tipo,
    required this.tituloPropiedad,
  });

  // Método para convertir un JSON a un objeto ContratoMenu
  factory ContratoMenu.fromJson(Map<String, dynamic> json) {
    return ContratoMenu(
      idContrato: json['id_contrato'] as int,
      tituloContrato: json['titulo_contrato'] as String,
      tipo: json['tipo'] as String,
      tituloPropiedad: json['titulo_propiedad'] as String,
    );
  }

  // Método para convertir un objeto ContratoMenu a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_contrato': idContrato,
      'titulo_contrato': tituloContrato,
      'tipo': tipo,
      'titulo_propiedad': tituloPropiedad,
    };
  }
}
