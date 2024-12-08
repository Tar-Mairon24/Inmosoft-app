import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/domain/models/imagen_modelo.dart';
import 'package:frontend/domain/models/propiedad_modelo.dart';
import 'package:frontend/services/imagen_service.dart';
import 'package:frontend/services/propiedad_service.dart';
import 'package:open_filex/open_filex.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class DetailedPropertyPage extends StatelessWidget {
  const DetailedPropertyPage(
      {super.key, required this.propertyID, required this.image});
  final int propertyID;
  final Image image;

  Future<void> generatePDF(Propiedad property, BuildContext context) async {
    try {
      // Crear el documento PDF
      final pdf = pw.Document();

      // Añadir contenido al PDF
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Ficha Técnica de la Propiedad",
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    )),
                pw.SizedBox(height: 20),
                pw.Text("Título: ${property.titulo}"),
                pw.Text("Fecha de alta: ${property.fechaAlta}"),
                pw.Text("Dirección: ${property.direccion}"),
                pw.Text("Colonia: ${property.colonia}"),
                pw.Text("Ciudad: ${property.ciudad}"),
                pw.Divider(),
                pw.Text("Precio: \$${property.precio}"),
                pw.Divider(),
                pw.Text("Detalles de la Propiedad:",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Construcción: ${property.mtsConstruccion} m²"),
                pw.Text("Terreno: ${property.mtsTerreno} m²"),
                pw.Text("Número de plantas: ${property.numPlantas}"),
                pw.Text("Número de recámaras: ${property.numRecamaras}"),
                pw.Text("Número de baños: ${property.numBanos}"),
                pw.Text("Cochera: ${property.sizeCochera} vehículos"),
                pw.Text("Jardín: ${property.mtsJardin} m²"),
                pw.Divider(),
                pw.Text("Servicios y Características:",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Habitada: ${property.habitada ? 'Sí' : 'No'}"),
                pw.Text("Amueblada: ${property.amueblada ? 'Sí' : 'No'}"),
                pw.Text(
                    "Gas: ${property.gas?.join(', ') ?? 'No especificado'}"),
                pw.Text(
                    "Comodidades: ${property.comodidades?.join(', ') ?? 'No especificado'}"),
                pw.Text(
                    "Utilidades: ${property.utilidades?.join(', ') ?? 'No especificado'}"),
                pw.Text(
                    "Extras: ${property.extras?.join(', ') ?? 'No especificado'}"),
                pw.Divider(),
                pw.Text(
                    "Observaciones: ${property.observaciones ?? 'No observaciones'}"),
              ],
            );
          },
        ),
      );

      // Obtener ruta de almacenamiento según la plataforma
      final outputDir = await getApplicationDocumentsDirectory();
      final file = File("${outputDir.path}/ficha_tecnica_$propertyID.pdf");

      // Guardar el archivo
      await file.writeAsBytes(await pdf.save());

      // Mostrar notificación al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("PDF generado: ${file.path}"),
          action: SnackBarAction(
            label: "Abrir",
            onPressed: () {
              // Abrir el archivo usando un visor de PDF
              OpenFilex.open(file.path); // Necesita el paquete open_file
            },
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al generar el PDF: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final PropiedadService propiedadService = PropiedadService();
    final ImagenService imagenService = ImagenService();

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: propiedadService.getPropiedad(propertyID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          Propiedad? property = snapshot.data!.data;
          double separation = MediaQuery.of(context).size.height * 0.02;
          final NumberFormat currencyFormat = NumberFormat("#,##0", "es_MX");
          String formattedPrice = currencyFormat.format(property!.precio);

          return Padding(
            padding:
                EdgeInsets.all(MediaQuery.of(context).size.aspectRatio * 14),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                            flex: 3,
                            child: FutureBuilder(
                              future: imagenService
                                  .getImagenesByPropiedad(propertyID),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                        "Error: ${snapshot.error.toString()}"),
                                  );
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data == null ||
                                    snapshot.data!.data == null) {
                                  return const Center(
                                    child: Text("No hay imágenes disponibles"),
                                  );
                                }

                                List<Imagen>? images = snapshot.data!.data;
                                return CarouselSlider(
                                  items: images!.map((image) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return ClipRRect(
                                          child: Image.file(
                                            File(image.rutaImagen),
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                  ),
                                );
                              },
                            )),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () =>
                                        generatePDF(property!, context),
                                    child: const Text('Ficha técnica'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.08,
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            property!.titulo,
                            style:
                                Theme.of(context).primaryTextTheme.titleLarge,
                          ),
                          SizedBox(height: separation),
                          Text("Fecha de alta: ${property.fechaAlta}"),
                          Text("Dirección: ${property.direccion}"),
                          Text("Colonia: ${property.colonia}"),
                          Text("Ciudad: ${property.ciudad}"),
                          SizedBox(height: separation),
                          const Divider(),
                          SizedBox(height: separation),
                          Text(
                            "Precio",
                          ),
                          Text(
                            "\$$formattedPrice",
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ),
                          SizedBox(height: separation),
                          const Divider(),
                          SizedBox(height: separation),
                          Text(
                            "Detalles de la propiedad",
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ),
                          Text("Construcción: ${property.mtsConstruccion} m²"),
                          Text("Terreno: ${property.mtsTerreno} m²"),
                          Text("Número de plantas: ${property.numPlantas}"),
                          Text("Número de recámaras: ${property.numRecamaras}"),
                          Text("Número de baños: ${property.numBanos}"),
                          Text(
                              "Cochera para: ${property.sizeCochera} vehículos"),
                          Text("Jardín: ${property.mtsJardin} m²"),
                          SizedBox(height: separation),
                          const Divider(),
                          SizedBox(height: separation),
                          Text(
                            "Servicios y Características",
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ),
                          Text("Habitada: ${property.habitada ? 'Sí' : 'No'}"),
                          Text(
                              "Amueblada: ${property.amueblada ? 'Sí' : 'No'}"),
                          Text(
                              "Gas: ${property.gas?.join(', ') ?? 'No especificado'}"),
                          Text(
                              "Comodidades: ${property.comodidades?.join(', ') ?? 'No especificado'}"),
                          Text(
                              "Utilidades: ${property.utilidades?.join(', ') ?? 'No especificado'}"),
                          Text(
                              "Extras: ${property.extras?.join(', ') ?? 'No especificado'}"),
                          SizedBox(height: separation),
                          const Divider(),
                          SizedBox(height: separation),
                          Text(
                            "Observaciones",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(property.observaciones ?? 'No observaciones'),
                        ],
                      ),
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
