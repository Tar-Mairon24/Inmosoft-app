import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PropertyImageWidget extends StatelessWidget {
  const PropertyImageWidget({super.key, required this.ruta});
  final String ruta;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.grey[400],
      ),
      child: Center(
        child: Expanded(
          child: Image.file(
            File(ruta),
          ),
        ),
      ),
    );
  }
}
