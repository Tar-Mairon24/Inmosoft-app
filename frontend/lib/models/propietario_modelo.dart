class Propietario{
  int idPropietario;
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String telefono;
  String correo;

  Propietario({
    required this.idPropietario,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.telefono,
    required this.correo,
  });

  factory Propietario.fromJson(Map<String, dynamic> json) {
    return Propietario(
      idPropietario: json['id_propietario'],
      nombre: json['nombre'],
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      telefono: json['telefono'],
      correo: json['correo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_propietario': idPropietario,
      'nombre': nombre,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'telefono': telefono,
      'correo': correo,
    };
  }
}