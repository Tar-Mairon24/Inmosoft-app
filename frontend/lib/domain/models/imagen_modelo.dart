class Imagen {
  final int idImagen;
  final String rutaImagen;
  final String? descripcion;
  final bool principal;
  final int idPropiedad;

  Imagen({
    required this.idImagen,
    required this.rutaImagen,
    required this.descripcion,
    required this.principal,
    required this.idPropiedad,
  });

  factory Imagen.fromJson(Map<String, dynamic> json) {
    return Imagen(
      idImagen: json['id_imagen'],
      rutaImagen: json['ruta_imagen'],
      descripcion: json['descripcion_imagen'],
      principal: json['principal'],
      idPropiedad: json['id_propiedad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_imagen': idImagen,
      'ruta_imagen': rutaImagen,
      'descripcion_imagen': descripcion,
      'principal': principal,
      'id_propiedad': idPropiedad,
    };
  }
}
