import 'package:flutter/material.dart';
import 'package:frontend/domain/models/citas_modelo.dart';
import 'package:frontend/presentation/navigator_key.dart';
import 'package:frontend/presentation/providers/appointments_notifier.dart';
import 'package:frontend/services/cita_service.dart';
import 'package:provider/provider.dart';

class AppointmentWidget extends StatelessWidget {
  const AppointmentWidget({
    super.key,
    required this.appointment,
    required this.image,
  });
  final CitaMenu appointment;
  final Image image;

  @override
  Widget build(BuildContext context) {
    final CitaService citaService = CitaService();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.aspectRatio * 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.aspectRatio * 18,
            backgroundColor: Colors.grey[400],
            backgroundImage: image.image,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.02), // Espacio entre el avatar y el contenido
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${appointment.nombre} ${appointment.apellidoPaterno} ${appointment.apellidoMaterno}",
                  style: Theme.of(context).primaryTextTheme.labelMedium,
                ),
                Text(
                  appointment.titulo,
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),
                Text(
                  appointment.fecha,
                  style: Theme.of(context).primaryTextTheme.labelMedium,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.01), // Espacio entre título y hora
                Text(
                  '${(appointment.hora ~/ 100).toString().padLeft(2, '0')}:${(appointment.hora % 100).toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.indigo),
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
                          "¿Está seguro de que desea eliminar esta cita?"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            //! Eliminar el contrato de la base de datos y actualizar el estado

                            await citaService.deleteCita(appointment.id);
                            Provider.of<AppointmentsNotifier>(
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
    );
  }
}
