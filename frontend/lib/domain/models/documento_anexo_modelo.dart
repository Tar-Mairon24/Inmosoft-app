class DocumentoAnexo {
  final int idDocumentoAnexo;
  final String? rutaDocumento;
  final String? descripcionDocumento;
  final int idPropiedad;

  DocumentoAnexo({
    required this.idDocumentoAnexo,
    this.rutaDocumento,
    this.descripcionDocumento,
    required this.idPropiedad,
  });

  // Método para convertir un mapa JSON a una instancia de DocumentoAnexo
  factory DocumentoAnexo.fromJson(Map<String, dynamic> json) {
    return DocumentoAnexo(
      idDocumentoAnexo: json['id_documento_anexo'] as int,
      rutaDocumento: json['ruta_documento'] as String?,
      descripcionDocumento: json['descripcion_documento_anexo'] as String?,
      idPropiedad: json['id_propiedad'] as int,
    );
  }

  // Método para convertir una instancia de DocumentoAnexo a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'id_documento_anexo': idDocumentoAnexo,
      'ruta_documento': rutaDocumento,
      'descripcion_documento_anexo': descripcionDocumento,
      'id_propiedad': idPropiedad,
    };
  }
}
