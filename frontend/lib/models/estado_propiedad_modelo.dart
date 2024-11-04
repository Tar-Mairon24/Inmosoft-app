class EstadoPropiedad {
  int idEstadoPropiedad;
  String tipoTransaccion;
  String estado;
  DateTime fechaCambioEstado;
  int idPropiedad;

  EstadoPropiedad({
    required this.idEstadoPropiedad,
    required this.tipoTransaccion,
    required this.estado,
    required this.fechaCambioEstado,
    required this.idPropiedad,
  });

  factory EstadoPropiedad.fromJson(Map<String, dynamic> json) {
    return EstadoPropiedad(
      idEstadoPropiedad: json['id_estado_propiedades'],
      tipoTransaccion: json['tipo_transaccion'],
      estado: json['estado'],
      fechaCambioEstado: DateTime.parse(json['fecha_cambio_estado']),
      idPropiedad: json['id_propiedad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_estado_propiedades': idEstadoPropiedad,
      'tipo_transaccion': tipoTransaccion,
      'estado': estado,
      'fecha_cambio_estado': fechaCambioEstado.toIso8601String(),
      'id_propiedad': idPropiedad,
    };
  }
}
