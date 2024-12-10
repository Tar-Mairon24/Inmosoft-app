import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/prospect_image_widget.dart';

class ProspectImagesRow extends StatefulWidget {
  final Function(List<String>) onPhotosUpdated;

  const ProspectImagesRow({super.key, required this.onPhotosUpdated});

  @override
  State<ProspectImagesRow> createState() => _ProspectImagesRowState();
}

class _ProspectImagesRowState extends State<ProspectImagesRow> {
  List<String> rutasImagenes = [];

  Future<void> _pickImage() async {
    if (rutasImagenes.isNotEmpty) {
      _showMaxImageDialog();
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

  void _showMaxImageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Solo puedes agregar una imagen por cita.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
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
          return ProspectImageWidget(
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
