// class Cita{
//   int id;
//   String titulo;
//   String fecha;
//   String hora;
//   String descripcion;
//   int idUsuario;
//   int idCliente;
//   int idPropiedad;

//   Cita({
//     required this.id, 
//     required this.titulo, 
//     required this.fecha, 
//     required this.hora, 
//     required this.descripcion, 
//     required this.idUsuario, 
//     required this.idCliente, 
//     required this.idPropiedad});
  
//   factory Cita.fromJson(Map<String, dynamic> json){
//     return Cita(
//       id: json['id_citas'],
//       titulo: json['titulo_cita'],
//       fecha: json['fecha_cita'],
//       hora: json['hora_cita'],
//       descripcion: json['descripcion_cita'],
//       idUsuario: json['id_usuario'],
//       idCliente: json['id_cliente'],
//       idPropiedad: json['id_propiedad']
//     );
//   }

//   Map<String, dynamic> toJson(){
//     return {
//       'id_citas': id,
//       'titulo_cita': titulo,
//       'fecha_cita': fecha,
//       'hora_cita': hora,
//       'descripcion_cita': descripcion,
//       'id_usuario': idUsuario,
//       'id_cliente': idCliente,
//       'id_propiedad': idPropiedad
//     };
//   }
// }

class Cita {
  final int id;
  final String titulo;
  final String fecha;
  final String hora;
  final String nombre;

  Cita({
    required this.id,
    required this.titulo,
    required this.fecha,
    required this.hora,
    required this.nombre,
  });

  factory Cita.fromJson(Map<String, dynamic> json) {
    return Cita(
      id: json['id'] ?? 0,
      titulo: json['titulo'] ?? '',
      fecha: json['fecha'] ?? '',
      hora: json['hora'] ?? '',
      nombre: json['nombre'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'fecha': fecha,
      'hora': hora,
      'nombre': nombre,
    };
  }
}