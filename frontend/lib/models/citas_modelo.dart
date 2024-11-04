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