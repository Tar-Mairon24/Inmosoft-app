import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/domain/models/imagen_modelo.dart';
import 'package:frontend/presentation/widgets/property_image_widget.dart';

class PropertyImagesRow extends StatefulWidget {
  final Function(List<String>)
      onPhotosUpdated; // Callback function to update photos

  const PropertyImagesRow({super.key, required this.onPhotosUpdated});

  @override
  State<PropertyImagesRow> createState() => _PropertyImagesRowState();
}

class _PropertyImagesRowState extends State<PropertyImagesRow> {
  // Lista de rutas de las fotos (usar strings para simplificar)
  List<String> rutasImagenes = [];

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Añadir un widget para agregar fotos si aún no existe
  //   if (photos.isEmpty) {
  //     photos.add(_buildAddPhotoWidget());
  //   }
  // }

  // Función para seleccionar una imagen
  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Filtra solo imágenes
    );

    final imagePath = result!.files.single.path;

    setState(() {
      rutasImagenes.add(
        imagePath!,
      );
      widget.onPhotosUpdated(
          rutasImagenes); // Llama al callback para actualizar las fotos en el widget padre
    });
  }

  // Widget para el botón de "Agregar fotografía"
  Widget _buildAddPhotoWidget() {
    return GestureDetector(
      onTap: _pickImage, // Llama a la función para seleccionar la imagen
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
                  "Agregar fotografía",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
            onTap: _pickImage, // Llama a la función para seleccionar la imagen
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
                        "Agregar fotografía",
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
          return PropertyImageWidget(
            ruta: rutasImagenes[i - 1],
          );
        }
      },
      separatorBuilder: (context, i) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.02,
      ),
      itemCount: rutasImagenes.length + 1, // Add 1 for the "Add photo" button
    );
  }
}
