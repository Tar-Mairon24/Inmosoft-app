class Prospecto {
  int idCliente;
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String telefono;
  String correo;

  Prospecto({
    required this.idCliente,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.telefono,
    required this.correo,
  });

  factory Prospecto.fromJson(Map<String, dynamic> json) {
    return Prospecto(
      idCliente: json['id_cliente'],
      nombre: json['nombre_prospecto'],
      apellidoPaterno: json['apellido_paterno_prospecto'],
      apellidoMaterno: json['apellido_materno_prospecto'],
      telefono: json['telefono_prospecto'],
      correo: json['correo_prospecto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cliente': idCliente,
      'nombre_prospecto': nombre,
      'apellido_paterno_prospecto': apellidoPaterno,
      'apellido_materno_prospecto': apellidoMaterno,
      'telefono_prospecto': telefono,
      'correo_prospecto': correo,
    };
  }
}
