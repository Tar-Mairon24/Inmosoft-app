import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class AgreementPdfWidget extends StatefulWidget {
  const AgreementPdfWidget({super.key, required this.ruta});
  final String ruta;

  @override
  _AgreementPdfWidgetState createState() => _AgreementPdfWidgetState();
}

class _AgreementPdfWidgetState extends State<AgreementPdfWidget> {
  late PdfDocument _pdfDocument;
  PdfPageImage? _pdfPageImage;

  @override
  void initState() {
    super.initState();
    _loadPdfPreview();
  }

  Future<void> _loadPdfPreview() async {
    try {
      // Cargar el documento PDF
      _pdfDocument = await PdfDocument.openFile(widget.ruta);

      // Renderizar la primera página como imagen
      final page = await _pdfDocument.getPage(1);
      _pdfPageImage = await page.render(
        width: 720, // Ajusta el tamaño según tus necesidades
        height: 1080,
        format: PdfPageImageFormat.png,
      );

      await page.close(); // Libera los recursos de la página

      setState(() {});
    } catch (e) {
      debugPrint("Error al cargar PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.grey[400],
      ),
      child: Center(
        child: _pdfPageImage == null
            ? const CircularProgressIndicator()
            : Image.memory(
                _pdfPageImage!.bytes,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
