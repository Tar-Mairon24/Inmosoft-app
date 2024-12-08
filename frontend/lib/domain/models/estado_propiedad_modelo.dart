class EstadoPropiedad {
  int idEstadoPropiedad;
  String tipoTransaccion;
  String estado;
  dynamic fechaCambioEstado;
  int idPropiedad;

  EstadoPropiedad({
    required this.idEstadoPropiedad,
    required this.tipoTransaccion,
    required this.estado,
    this.fechaCambioEstado,
    required this.idPropiedad,
  });

  factory EstadoPropiedad.fromJson(Map<String, dynamic> json) {
    return EstadoPropiedad(
      idEstadoPropiedad: json['id_estado_propiedades'],
      tipoTransaccion: json['tipo_transaccion'],
      estado: json['estado'],
      fechaCambioEstado: json['fecha_cambio_estado'],
      idPropiedad: json['id_propiedad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_estado_propiedades': idEstadoPropiedad,
      'tipo_transaccion': tipoTransaccion,
      'estado': estado,
      'fecha_cambio_estado': fechaCambioEstado,
      'id_propiedad': idPropiedad,
    };
  }
}
