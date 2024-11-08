class EstadoPropiedad {
  int idEstadoPropiedad;
  String tipoTransaccion;
  String estado;
  DateTime? fechaTransaccion;
  int idPropiedad;

  EstadoPropiedad({
    required this.idEstadoPropiedad,
    required this.tipoTransaccion,
    required this.estado,
    this.fechaTransaccion,
    required this.idPropiedad,
  });

  factory EstadoPropiedad.fromJson(Map<String, dynamic> json) {
    return EstadoPropiedad(
      idEstadoPropiedad: json['id_estado_propiedades'],
      tipoTransaccion: json['tipo_transaccion'],
      estado: json['estado'],
      fechaTransaccion: json['fecha_transaccion'] != null
          ? DateTime.parse(json['fecha_transaccion'])
          : null,
      idPropiedad: json['id_propiedad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_estado_propiedades': idEstadoPropiedad,
      'tipo_transaccion': tipoTransaccion,
      'estado': estado,
      'fecha_transaccion': fechaTransaccion?.toIso8601String(),
      'id_propiedad': idPropiedad,
    };
  }
}
