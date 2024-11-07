import 'package:flutter/material.dart';
import 'package:frontend/models/propiedad_modelo.dart';
import 'package:frontend/services/propiedad_service.dart';

class DetailedPropertyPage extends StatelessWidget {
  const DetailedPropertyPage(
      {super.key, required this.propertyID, required this.image});
  final int propertyID;
  final Image image;

  @override
  Widget build(BuildContext context) {
    final PropiedadService propiedadService = PropiedadService();
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
                          child:
                              Container(color: Colors.grey[400], child: image),
                        ),
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
                                    onPressed: () {},
                                    child: const Text('Ficha técnica'),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () {},
                                    child: const Text('Generar publicidad'),
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
                          Text("\$${property.precio}",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium),
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
                          Text("Gas: ${property.gas.join(', ')}"),
                          Text(
                              "Comodidades: ${property.comodidades.join(', ')}"),
                          Text("Utilidades: ${property.utilidades.join(', ')}"),
                          Text("Extras: ${property.extras.join(', ')}"),
                          SizedBox(height: separation),
                          const Divider(),
                          SizedBox(height: separation),
                          Text(
                            "Observaciones",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(property.observaciones),
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
