import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/domain/models/imagen_modelo.dart';
import 'package:frontend/presentation/widgets/agreement_pdf_widget.dart';
import 'package:frontend/presentation/widgets/property_image_widget.dart';

class AgreementPdfsRow extends StatefulWidget {
  final Function(List<String>)
      onPdfsUpdated; // Callback function to update photos

  const AgreementPdfsRow({super.key, required this.onPdfsUpdated});

  @override
  State<AgreementPdfsRow> createState() => _AgreementPdfsRowState();
}

class _AgreementPdfsRowState extends State<AgreementPdfsRow> {
  // Lista de rutas de las fotos (usar strings para simplificar)
  List<String> rutasPdfs = [];

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Añadir un widget para agregar fotos si aún no existe
  //   if (photos.isEmpty) {
  //     photos.add(_buildAddPhotoWidget());
  //   }
  // }

  // Función para seleccionar una imagen
  Future<void> _pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    final pdfPath = result!.files.single.path;

    setState(() {
      rutasPdfs.add(
        pdfPath!,
      );
      widget.onPdfsUpdated(
          rutasPdfs); // Llama al callback para actualizar las fotos en el widget padre
    });
  }

  // Widget para el botón de "Agregar fotografía"

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      // itemBuilder: (context, i) {
      //   return photos[i];
      // },
      itemBuilder: (context, i) {
        if (i == 0) {
          return GestureDetector(
            onTap: _pickPdf, // Llama a la función para seleccionar la imagen
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Theme.of(context).iconTheme.color,
                        size: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Text(
                        "PDF del contrato",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).primaryTextTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return AgreementPdfWidget(
            ruta: rutasPdfs[i - 1],
          );
        }
      },
      separatorBuilder: (context, i) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.02,
      ),
      itemCount: rutasPdfs.length + 1, // Add 1 for the "Add photo" button
    );
  }
}
