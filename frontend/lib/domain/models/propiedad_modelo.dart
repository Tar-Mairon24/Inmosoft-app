class Propiedad {
  int idPropiedad;
  String titulo;
  String fechaAlta;
  String direccion;
  String colonia;
  String ciudad;
  String referencia;
  double precio;
  int mtsConstruccion;
  int mtsTerreno;
  bool habitada;
  bool amueblada;
  int numPlantas;
  int numRecamaras;
  int numBanos;
  int sizeCochera;
  int mtsJardin;
  List<String>? gas;
  List<String>? comodidades;
  List<String>? extras;
  List<String>? utilidades;
  String? observaciones;
  int idTipoPropiedad;
  int idPropietario;
  String idUsuario;

  Propiedad({
    required this.idPropiedad,
    required this.titulo,
    required this.fechaAlta,
    required this.direccion,
    required this.colonia,
    required this.ciudad,
    required this.referencia,
    required this.precio,
    required this.mtsConstruccion,
    required this.mtsTerreno,
    required this.habitada,
    required this.amueblada,
    required this.numPlantas,
    required this.numRecamaras,
    required this.numBanos,
    required this.sizeCochera,
    required this.mtsJardin,
    this.gas,
    this.comodidades,
    this.extras,
    this.utilidades,
    this.observaciones,
    required this.idTipoPropiedad,
    required this.idPropietario,
    required this.idUsuario,
  });

  factory Propiedad.fromJson(Map<String, dynamic> json) {
    return Propiedad(
      idPropiedad: json['id_propiedad'],
      titulo: json['titulo'],
      fechaAlta: json['fecha_alta'],
      direccion: json['direccion'],
      colonia: json['colonia'],
      ciudad: json['ciudad'],
      referencia: json['referencia'],
      precio: json['precio'].toDouble(),
      mtsConstruccion: json['mts_construccion'],
      mtsTerreno: json['mts_terreno'],
      habitada: json['habitada'],
      amueblada: json['amueblada'],
      numPlantas: json['num_plantas'],
      numRecamaras: json['num_recamaras'],
      numBanos: json['num_banos'],
      sizeCochera: json['size_cochera'],
      mtsJardin: json['mts_jardin'],
      gas: json['gas'] != null ? List<String>.from(json['gas']) : null,
      comodidades: json['comodidades'] != null
          ? List<String>.from(json['comodidades'])
          : null,
      extras: json['extras'] != null ? List<String>.from(json['extras']) : null,
      utilidades: json['utilidades'] != null
          ? List<String>.from(json['utilidades'])
          : null,
      observaciones: json['observaciones'],
      idTipoPropiedad: json['id_tipo_propiedad'],
      idPropietario: json['id_propietario'],
      idUsuario: json['usuario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_propiedad': idPropiedad,
      'titulo': titulo,
      'fecha_alta': fechaAlta,
      'direccion': direccion,
      'colonia': colonia,
      'ciudad': ciudad,
      'referencia': referencia,
      'precio': precio,
      'mts_construccion': mtsConstruccion,
      'mts_terreno': mtsTerreno,
      'habitada': habitada,
      'amueblada': amueblada,
      'num_plantas': numPlantas,
      'num_recamaras': numRecamaras,
      'num_banos': numBanos,
      'size_cochera': sizeCochera,
      'mts_jardin': mtsJardin,
      'gas': gas,
      'comodidades': comodidades,
      'extras': extras,
      'utilidades': utilidades,
      'observaciones': observaciones,
      'id_tipo_propiedad': idTipoPropiedad,
      'id_propietario': idPropietario,
      'usuario': idUsuario,
    };
  }
}
