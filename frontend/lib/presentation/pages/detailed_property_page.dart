import 'package:flutter/material.dart';
import 'package:frontend/models/propiedad_modelo.dart';
import 'package:frontend/services/propiedad_service.dart';

class DetailedPropertyPage extends StatelessWidget {
  const DetailedPropertyPage({super.key, required this.propertyID});
  final int propertyID;

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
                    child: Text("error: ${snapshot.error.toString()}"));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Image> images = [
                Image.asset('assets/images/images.jpeg'),
                Image.asset('assets/images/images2.jpg'),
                Image.asset('assets/images/images10.jpeg'),
                Image.asset('assets/images/images11.jpg'),
                Image.asset('assets/images/images12.jpeg'),
                Image.asset('assets/images/images13.jpeg'),
              ];

              Propiedad? property = snapshot.data!.data;
              return Padding(
                padding: EdgeInsets.all(
                    MediaQuery.of(context).size.aspectRatio * 14),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: images[propertyID],
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
                                    child: Text('Ficha técnica'),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () {},
                                    child: Text('Generar publicidad'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          property!.titulo,
                          style: Theme.of(context).primaryTextTheme.titleLarge,
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(property.direccion),
                                Text("Precio: ${property.precio}"),
                                Text("Estado: "),
                                Text(
                                    "Número de habitaciones: ${property.numRecamaras}"),
                                Text(property.observaciones)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              );
            }));
  }
}
