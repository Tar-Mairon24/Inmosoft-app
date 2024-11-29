import 'package:flutter/material.dart';
import 'package:frontend/domain/models/contrato_modelo.dart';

class AgreementWidget extends StatelessWidget {
  const AgreementWidget({super.key, required this.contrato});
  final ContratoMenu contrato;

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
        isThreeLine: true,
        leading: CircleAvatar(
          backgroundColor: Colors.grey[400],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contrato.tipo!,
              style: Theme.of(context).primaryTextTheme.bodySmall,
            ),
            Text(
              contrato.tituloContrato,
              style: Theme.of(context).primaryTextTheme.titleMedium,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contrato.tituloPropiedad),
          ],
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
