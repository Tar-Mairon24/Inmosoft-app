import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/domain/models/imagen_modelo.dart';
import 'package:frontend/domain/models/propiedad_menu_modelo.dart';
import 'package:frontend/presentation/navigator_key.dart';
import 'package:frontend/presentation/pages/detailed_property_page.dart';
import 'package:frontend/presentation/pages/property_modifier_page.dart';
import 'package:frontend/presentation/providers/properties_notifier.dart';
import 'package:frontend/services/estado_propiedad_service.dart';
import 'package:frontend/services/imagen_service.dart';
import 'package:frontend/services/propiedad_service.dart';
import 'package:provider/provider.dart';

class PropertyWidget extends StatelessWidget {
  final PropiedadMenu property;
  final Image image;

  const PropertyWidget({
    super.key,
    required this.property,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final PropiedadService propiedadService = PropiedadService();
    final EstadoPropiedadService estadoPropiedadService =
        EstadoPropiedadService();
    final ImagenService imagenService = ImagenService();
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailedPropertyPage(
                image: image,
                propertyID: property.idPropiedad,
              ))),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.grey[400],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: FutureBuilder(
                      future: imagenService
                          .getImagenPrincipal(property.idPropiedad),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text("error: ${snapshot.error.toString()}"));
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        Imagen? image = snapshot.data!.data;
                        return Image.file(File(image!.rutaImagen));
                      })),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.01),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              property.titulo,
                              style:
                                  Theme.of(context).primaryTextTheme.titleSmall,
                            ),
                            Text(
                              property.estado,
                              style:
                                  Theme.of(context).primaryTextTheme.bodySmall,
                            ),
                            Text(
                              "${property.precio} MXN",
                              style:
                                  Theme.of(context).primaryTextTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PropertyModifierPage(
                                  propertyID: property.idPropiedad,
                                ),
                              ),
                            ),
                            child: const Text('Editar'),
                          ),
                          PopupMenuItem<String>(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: const Text(
                                      "¿Está seguro de que desea eliminar esta propiedad?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        await estadoPropiedadService
                                            .deleteEstadoPropiedad(
                                                property.idPropiedad);
                                        await propiedadService.deletePropiedad(
                                            property.idPropiedad);
                                        Provider.of<PropertiesNotifier>(
                                                navigatorKey.currentContext!,
                                                listen: false)
                                            .shouldRefresh();

                                        Navigator.pop(context);
                                      },
                                      child: const Text("SI"),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("NO"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text('Borrar'),
                          ),
                        ],
                        icon: const Icon(Icons.more_vert_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
