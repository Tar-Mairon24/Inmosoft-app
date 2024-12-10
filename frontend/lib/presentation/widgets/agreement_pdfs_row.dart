import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/agreement_pdf_widget.dart';

class AgreementPdfsRow extends StatefulWidget {
  final Function(List<String>) onPdfsUpdated;

  const AgreementPdfsRow({super.key, required this.onPdfsUpdated});

  @override
  State<AgreementPdfsRow> createState() => _AgreementPdfsRowState();
}

class _AgreementPdfsRowState extends State<AgreementPdfsRow> {
  List<String> rutasPdfs = [];

  Future<void> _pickPdf() async {
    if (rutasPdfs.isNotEmpty) {
      _showMaxPdfDialog();
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final pdfPath = result.files.single.path;
      if (pdfPath != null) {
        setState(() {
          rutasPdfs.add(pdfPath);
          widget.onPdfsUpdated(rutasPdfs);
        });
      }
    }
  }

  void _showMaxPdfDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Solo puedes agregar un PDF por contrato.'),
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
            onTap: _pickPdf,
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
      itemCount: rutasPdfs.length + 1,
    );
  }
}
