class Prospecto {
  int idCliente;
  String? nombreProspecto;
  String? apellidoPaternoProspecto;
  String? apellidoMaternoProspecto;
  String? telefonoProspecto;
  String? correoProspecto;

  Prospecto({
    required this.idCliente,
    this.nombreProspecto,
    this.apellidoPaternoProspecto,
    this.apellidoMaternoProspecto,
    this.telefonoProspecto,
    this.correoProspecto,
  });

  // Método para crear una instancia de Prospecto a partir de un JSON
  factory Prospecto.fromJson(Map<String, dynamic> json) {
    return Prospecto(
      idCliente: json['id_cliente'],
      nombreProspecto: json['nombre_prospecto'],
      apellidoPaternoProspecto: json['apellido_paterno_prospecto'],
      apellidoMaternoProspecto: json['apellido_materno_prospecto'],
      telefonoProspecto: json['telefono_prospecto'],
      correoProspecto: json['correo_prospecto'],
    );
  }

  // Método para convertir una instancia de Prospecto a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_cliente': idCliente,
      'nombre_prospecto': nombreProspecto,
      'apellido_paterno_prospecto': apellidoPaternoProspecto,
      'apellido_materno_prospecto': apellidoMaternoProspecto,
      'telefono_prospecto': telefonoProspecto,
      'correo_prospecto': correoProspecto,
    };
  }
}
