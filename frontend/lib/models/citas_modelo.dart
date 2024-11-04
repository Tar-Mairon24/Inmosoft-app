class Cita{
  int id;
  String titulo;
  String fecha;
  String hora;
  String descripcion;
  int idUsuario;
  int idCliente;
  int idPropiedad;

  Cita({
    required this.id, 
    required this.titulo, 
    required this.fecha, 
    required this.hora, 
    required this.descripcion, 
    required this.idUsuario, 
    required this.idCliente, 
    required this.idPropiedad});
  
  factory Cita.fromJson(Map<String, dynamic> json){
    return Cita(
      id: json['id_citas'],
      titulo: json['titulo_cita'],
      fecha: json['fecha_cita'],
      hora: json['hora_cita'],
      descripcion: json['descripcion_cita'],
      idUsuario: json['id_usuario'],
      idCliente: json['id_cliente'],
      idPropiedad: json['id_propiedad']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id_citas': id,
      'titulo_cita': titulo,
      'fecha_cita': fecha,
      'hora_cita': hora,
      'descripcion_cita': descripcion,
      'id_usuario': idUsuario,
      'id_cliente': idCliente,
      'id_propiedad': idPropiedad
    };
  }
}

class CitaMenu {
  final int id;
  final String titulo;
  final String fecha;
  final int hora;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;

  CitaMenu({
    required this.id,
    required this.titulo,
    required this.fecha,
    required this.hora,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
  });

  factory CitaMenu.fromJson(Map<String, dynamic> json) {
    return CitaMenu(
      id: json['id_cita'] ?? 0,
      titulo: json['titulo'] ?? '',
      fecha: json['fecha_cita'] ?? '',
      hora: json['hora_cita'] ?? 0,
      nombre: json['nombre_clienta'] ?? '',
      apellidoPaterno: json['apellido_paterno_cliente'] ?? '',
      apellidoMaterno: json['apellido_materno_cliente'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cita': id,
      'titulo': titulo,
      'fecha_cita': fecha,
      'hora_cita': hora,
      'nombre_cita': nombre,
      'apellido_paterno_cita': apellidoPaterno,
      'apellido_materno_cita': apellidoMaterno,
    };
  }
}