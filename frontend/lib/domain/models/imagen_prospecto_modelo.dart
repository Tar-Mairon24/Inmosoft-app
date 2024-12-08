class ImagenProspecto {
  final int idImagen;
  final String rutaImagen;
  final String? descripcion;
  final bool principal;
  final int idProspecto;

  ImagenProspecto({
    required this.idImagen,
    required this.rutaImagen,
    required this.descripcion,
    required this.principal,
    required this.idProspecto,
  });

  factory ImagenProspecto.fromJson(Map<String, dynamic> json) {
    return ImagenProspecto(
      idImagen: json['id_imagen'],
      rutaImagen: json['ruta_imagen'],
      descripcion: json['descripcion_imagen'],
      principal: json['principal'],
      idProspecto: json['id_prospecto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_imagen': idImagen,
      'ruta_imagen': rutaImagen,
      'descripcion_imagen': descripcion,
      'principal': principal,
      'id_prospecto': idProspecto,
    };
  }
}
