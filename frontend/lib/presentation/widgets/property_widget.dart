import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/detailed_property_page.dart';
import 'package:frontend/presentation/pages/property_modifier_page.dart';
import 'package:frontend/services/propiedad_service.dart';
import 'package:provider/provider.dart';

class PropertyWidget extends StatelessWidget {
  final Image image;
  final String title;
  final String status;
  final double price;

  const PropertyWidget({
    super.key,
    required this.image,
    required this.title,
    required this.status,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final PropiedadService propiedadService = PropiedadService();
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailedPropertyPage())),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.grey[400],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: image),
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
                              title,
                              style:
                                  Theme.of(context).primaryTextTheme.titleSmall,
                            ),
                            Text(
                              status,
                              style:
                                  Theme.of(context).primaryTextTheme.bodySmall,
                            ),
                            Text(
                              "$price MXN",
                              style:
                                  Theme.of(context).primaryTextTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            onTap: () {},
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
                                      //                           onPressed: (_) async {
                                      //                             //! Eliminar la propiedad de la base de datos y actualizar el estado
                                      //                             Provider.of<>(navigatorKey.currentContext!,
                                      //     listen: false)
                                      // .shouldRefresh();
                                      // await propiedadService.
                                      //                           },
                                      onPressed: () {},
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
