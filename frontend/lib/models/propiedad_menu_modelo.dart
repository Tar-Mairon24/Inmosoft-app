class PropiedadMenu {
  final int idPropiedad;
  final String titulo;
  final double precio;
  final String tipoTransaccion;
  final String estado;

  PropiedadMenu(
      {required this.idPropiedad,
      required this.titulo,
      required this.precio,
      required this.tipoTransaccion,
      required this.estado});

  factory PropiedadMenu.fromJson(Map<String, dynamic> json) {
    return PropiedadMenu(
      idPropiedad: json['id_propiedad'],
      titulo: json['titulo'] as String? ?? 'Unknown',
      precio: (json['precio'] as num?)?.toDouble() ?? 0.0,
      tipoTransaccion: json['tipoTransaccion'] as String? ?? 'Unknown',
      estado: json['estado'] as String? ?? 'Unknown',
    );
  }
}
