import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:frontend/domain/models/contrato_modelo.dart';
import 'package:frontend/services/contrato_service.dart';

class DetailedAgreementPage extends StatefulWidget {
  const DetailedAgreementPage({super.key, required this.agreementID});
  final int agreementID;

  @override
  State<DetailedAgreementPage> createState() => _DetailedAgreementPageState();
}

class _DetailedAgreementPageState extends State<DetailedAgreementPage> {
  final ContratoService contratoService = ContratoService();
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int currentIndex = 0;
  Future<List<PdfPageImage>>? _pdfPagesFuture;

  Future<List<PdfPageImage>> _loadPdfPages(String? pdfPath) async {
    if (pdfPath == null || !File(pdfPath).existsSync()) {
      throw Exception("El archivo PDF no existe o la ruta no es válida.");
    }

    final pdfDocument = await PdfDocument.openFile(pdfPath);
    final pageCount = pdfDocument.pagesCount;
    List<PdfPageImage> pdfPages = [];

    for (int i = 1; i <= pageCount; i++) {
      final page = await pdfDocument.getPage(i);
      final image = await page.render(
        width: 612,
        height: 792,
        format: PdfPageImageFormat.png,
      );
      await page.close();
      pdfPages.add(image!);
    }

    return pdfPages;
  }

  @override
  void initState() {
    super.initState();
    _pdfPagesFuture =
        contratoService.getContrato(widget.agreementID).then((contratoData) {
      final Contrato? contrato = contratoData.data;
      return _loadPdfPages(contrato?.rutaPDF);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: contratoService.getContrato(widget.agreementID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          Contrato? contrato = snapshot.data!.data;
          double separation = MediaQuery.of(context).size.height * 0.02;

          return Padding(
            padding:
                EdgeInsets.all(MediaQuery.of(context).size.aspectRatio * 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder<List<PdfPageImage>>(
                          future: _pdfPagesFuture,
                          builder: (context, pdfSnapshot) {
                            if (pdfSnapshot.hasError) {
                              return Center(
                                child: Text(
                                    "Error al cargar el PDF: ${pdfSnapshot.error}"),
                              );
                            }
                            if (!pdfSnapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            List<PdfPageImage> pdfPages = pdfSnapshot.data!;
                            return Column(
                              children: [
                                Expanded(
                                  child: CarouselSlider.builder(
                                    carouselController: _carouselController,
                                    itemCount: pdfPages.length,
                                    itemBuilder: (context, index, realIndex) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          color: Colors.grey[400],
                                        ),
                                        child: Image.memory(
                                          pdfPages[index].bytes,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: false,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          currentIndex = index;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: currentIndex > 0
                                          ? () {
                                              _carouselController
                                                  .previousPage();
                                            }
                                          : null,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_left_outlined),
                                    ),
                                    Text(
                                      "${currentIndex + 1} de ${pdfPages.length}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    IconButton(
                                      onPressed: currentIndex <
                                              pdfPages.length - 1
                                          ? () {
                                              _carouselController.nextPage();
                                            }
                                          : null,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_right_outlined),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.08,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          contrato!.tituloContrato,
                          style: Theme.of(context).primaryTextTheme.titleLarge,
                        ),
                        SizedBox(height: separation),
                        Text(contrato.descripcionContrato ?? 'No especificada'),
                        SizedBox(height: separation),
                        const Divider(),
                        SizedBox(height: separation),
                        Text(
                          "Detalles del contrato",
                          style: Theme.of(context).primaryTextTheme.titleMedium,
                        ),
                        Text("Tipo: ${contrato.tipo ?? 'No especificado'}"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
