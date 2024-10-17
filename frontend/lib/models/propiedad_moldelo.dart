class PropiedadMenu {
  final String titulo;
  final double precio;
  final String tipoTransaccion;
  final String estado;

  PropiedadMenu({required this.titulo, required this.precio, required this.tipoTransaccion, required this.estado});

  factory PropiedadMenu.fromJson(Map<String, dynamic> json) {
    return PropiedadMenu(
      titulo: json['titulo'],
      precio: json['precio'],
      tipoTransaccion: json['tipoTransaccion'],
      estado: json['estado'],
    );
  }
}