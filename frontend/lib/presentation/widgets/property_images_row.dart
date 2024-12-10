import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/property_image_widget.dart';

class PropertyImagesRow extends StatefulWidget {
  final Function(List<String>) onPhotosUpdated;

  const PropertyImagesRow({super.key, required this.onPhotosUpdated});

  @override
  State<PropertyImagesRow> createState() => _PropertyImagesRowState();
}

class _PropertyImagesRowState extends State<PropertyImagesRow> {
  List<String> rutasImagenes = [];
  final int maxImages = 15;

  Future<void> _pickImage() async {
    if (rutasImagenes.length >= maxImages) {
      _showMaxImagesDialog();
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      final imagePath = result.files.single.path;
      if (imagePath != null) {
        setState(() {
          rutasImagenes.add(imagePath);
          widget.onPhotosUpdated(rutasImagenes);
        });
      }
    }
  }

  void _showMaxImagesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Solo puedes agregar hasta $maxImages imágenes.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) {
        if (i == 0) {
          return GestureDetector(
            onTap: _pickImage,
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
      itemCount: rutasImagenes.length + 1,
    );
  }
}
