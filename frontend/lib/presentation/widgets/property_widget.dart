import 'package:flutter/material.dart';

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
    // Usamos MediaQuery para obtener el tamaño de la pantalla.
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width:
          screenWidth * 0.45, // Ajusta el ancho a un porcentaje de la pantalla.
      height:
          screenWidth * 0.55, // Ajusta la altura proporcionalmente al ancho.
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.grey[400],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // El widget Expanded permite que la imagen ocupe el espacio disponible.
            Expanded(child: image),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Usamos Expanded y ajustamos el estilo del texto según el tamaño de la pantalla.
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth *
                                  0.01, // Tamaño de fuente adaptativo
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            status,
                            style: TextStyle(
                              fontSize: screenWidth *
                                  0.01, // Tamaño de fuente adaptativo
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            "$price MXN",
                            style: TextStyle(
                              fontSize: screenWidth *
                                  0.01, // Tamaño de fuente adaptativo
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      color: Colors.white,
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          onTap: () {
                            // Acción de edición
                          },
                          child: const Text('Editar'),
                        ),
                        PopupMenuItem<String>(
                          onTap: () {
                            // Mostramos un diálogo de confirmación para borrar
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: const Text(
                                      "¿Está seguro de que desea eliminar esta propiedad?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        // Acción de confirmación para borrar
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("SI"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("NO"),
                                    ),
                                  ],
                                ),
                              );
                            });
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
    );
  }
}
