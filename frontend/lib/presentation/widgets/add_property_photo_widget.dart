import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddPropertyPhotoWidget extends StatelessWidget {
  const AddPropertyPhotoWidget({super.key});

  Future<void> _pickImage() async {
    // Abre el explorador de archivos
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Filtra solo imágenes
    );

    if (result != null && result.files.isNotEmpty) {
      final imagePath = result.files.single.path;
      print(
          "Ruta de la imagen seleccionada: $imagePath"); // Imprime la ruta en la consola
    } else {
      print("No se seleccionó ninguna imagen.");
    }
  }

  @override
  Widget build(BuildContext context) {
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
}
