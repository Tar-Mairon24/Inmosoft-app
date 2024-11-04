class Propiedad {
  int idPropiedad;
  String titulo;
  DateTime fechaAlta;
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
  List<String> gas;
  List<String> comodidades;
  List<String> extras;
  List<String> utilidades;
  String observaciones;
  int idTipoPropiedad;
  int idPropietario;
  int idUsuario;

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
    required this.gas,
    required this.comodidades,
    required this.extras,
    required this.utilidades,
    required this.observaciones,
    required this.idTipoPropiedad,
    required this.idPropietario,
    required this.idUsuario,
  });

  factory Propiedad.fromJson(Map<String, dynamic> json) {
    return Propiedad(
      idPropiedad: json['id_propiedad'],
      titulo: json['titulo'],
      fechaAlta: DateTime.parse(json['fecha_alta']),
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
      gas: List<String>.from(json['gas']),
      comodidades: List<String>.from(json['comodidades']),
      extras: List<String>.from(json['extras']),
      utilidades: List<String>.from(json['utilidades']),
      observaciones: json['observaciones'],
      idTipoPropiedad: json['id_tipo_propiedad'],
      idPropietario: json['id_propietario'],
      idUsuario: json['id_usuario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_propiedad': idPropiedad,
      'titulo': titulo,
      'fecha_alta': fechaAlta.toIso8601String(),
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
      'id_usuario': idUsuario,
    };
  }
}

class PropiedadMenu {
  final String titulo;
  final double precio;
  final String tipoTransaccion;
  final String estado;

  PropiedadMenu({required this.titulo, required this.precio, required this.tipoTransaccion, required this.estado});

  factory PropiedadMenu.fromJson(Map<String, dynamic> json) {
    return PropiedadMenu(
      titulo: json['titulo'] as String? ?? 'Unknown',
      precio: (json['precio'] as num?)?.toDouble() ?? 0.0,
      tipoTransaccion: json['tipoTransaccion'] as String? ?? 'Unknown',
      estado: json['estado'] as String? ?? 'Unknown',
    );
  }
}

class Estado {
  final int idEstadoPropiedades;
  final String tipoTransaccion;
  final String estado;
  final DateTime fechaCambioEstado;
  final int idPropiedad;

  Estado({
    required this.idEstadoPropiedades,
    required this.tipoTransaccion,
    required this.estado,
    required this.fechaCambioEstado,
    required this.idPropiedad,
  });

  factory Estado.fromJson(Map<String, dynamic> json) {
    return Estado(
      idEstadoPropiedades: json['id_estado_propiedades'],
      tipoTransaccion: json['tipo_transaccion'],
      estado: json['estado'],
      fechaCambioEstado: DateTime.parse(json['fecha_cambio_estado']),
      idPropiedad: json['id_propiedad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_estado_propiedades': idEstadoPropiedades,
      'tipo_transaccion': tipoTransaccion,
      'estado': estado,
      'fecha_cambio_estado': fechaCambioEstado.toIso8601String(),
      'id_propiedad': idPropiedad,
    };
  }
}

class PropiedadEstado {
  final Propiedad propiedad;
  final Estado estadoPropiedades;

  PropiedadEstado({
    required this.propiedad,
    required this.estadoPropiedades,
  });

  factory PropiedadEstado.fromJson(Map<String, dynamic> json) {
    return PropiedadEstado(
      propiedad: Propiedad.fromJson(json['propiedad']),
      estadoPropiedades: Estado.fromJson(json['estado_propiedades']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propiedad': propiedad.toJson(),
      'estado_propiedades': estadoPropiedades.toJson(),
    };
  }
}
