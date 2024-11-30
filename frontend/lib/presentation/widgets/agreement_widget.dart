import 'package:flutter/material.dart';
import 'package:frontend/domain/models/contrato_modelo.dart';
import 'package:frontend/presentation/navigator_key.dart';
import 'package:frontend/presentation/pages/agreement_modifier_page.dart';
import 'package:frontend/services/contrato_service.dart';
import 'package:frontend/presentation/providers/agreements_notifier.dart';
import 'package:provider/provider.dart';

class AgreementWidget extends StatelessWidget {
  const AgreementWidget({
    super.key,
    required this.contrato,
    // required this.image,
  });

  final ContratoMenu contrato;
  // final Image image;

  @override
  Widget build(BuildContext context) {
    final ContratoService contratoService = ContratoService();

    return GestureDetector(
      onTap: () {
        // Aquí puedes agregar navegación a una página detallada del contrato.
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.aspectRatio * 20,
            horizontal: MediaQuery.of(context).size.aspectRatio * 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contrato.tipo ?? "Sin tipo",
                    style: Theme.of(context).primaryTextTheme.labelMedium,
                  ),
                  Text(
                    contrato.tituloContrato,
                    style: Theme.of(context).primaryTextTheme.titleMedium,
                  ),
                  Text(
                    contrato.tituloPropiedad,
                    style: Theme.of(context).primaryTextTheme.bodySmall,
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AgreementModifierPage(
                        agreementID: contrato.idContrato,
                        tituloPropiedad: contrato.tituloPropiedad,
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
                            "¿Está seguro de que desea eliminar este contrato?"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await contratoService
                                  .deleteContrato(contrato.idContrato);
                              Provider.of<AgreementsNotifier>(
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
    );
  }
}
