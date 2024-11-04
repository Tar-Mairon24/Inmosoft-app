import 'package:flutter/material.dart';

class AppointmentWidget extends StatelessWidget {
  const AppointmentWidget(
      {super.key, required this.title, required this.name, required this.fecha, required this.hour});
  final String title;
  final String name;
  final String fecha;
  final int hour;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: ListTile(
        contentPadding:
            EdgeInsets.all(MediaQuery.of(context).size.aspectRatio * 12),
        dense: true,
        leading: CircleAvatar(
          backgroundColor: Colors.grey[400],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).primaryTextTheme.labelMedium,
            ),
            Text(
              title,
              style: Theme.of(context).primaryTextTheme.titleMedium,
            ),
            Text(
              fecha.split('T').first,
              style: Theme.of(context).primaryTextTheme.labelMedium,
            ),
          ],
        ),
        subtitle: Text(
            '${(hour ~/ 100).toString().padLeft(2, '0')}:${(hour % 100).toString().padLeft(2, '0')}',
          style: TextStyle(color: Colors.indigo),
        ),
        trailing: PopupMenuButton<String>(
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
                        "¿Está seguro de que desea eliminar este contrato?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          //! Eliminar el contrato de la base de datos y actualizar el estado
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
      ),
    );
  }
}
