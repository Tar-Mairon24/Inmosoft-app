import 'package:flutter/material.dart';
import 'package:frontend/domain/models/citas_modelo.dart';
import 'package:frontend/domain/models/prospecto_modelo.dart';
import 'package:frontend/services/cita_service.dart';
import 'package:frontend/services/prospecto_service.dart';

class DetailedAppointmentPage extends StatelessWidget {
  const DetailedAppointmentPage(
      {super.key, required this.appointmentID, required this.image});
  final int appointmentID;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final Prospecto prospecto = snapshot.data![0].data;
          final Cita cita = snapshot.data![1].data;
          double separation = MediaQuery.of(context).size.height * 0.02;

          return Padding(
            padding:
                EdgeInsets.all(MediaQuery.of(context).size.aspectRatio * 14),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.aspectRatio * 102,
                      backgroundColor: Colors.grey[400],
                      backgroundImage: image.image,
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
                          children: [
                            Text(cita.titulo,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge),
                            SizedBox(height: separation * 3),
                            // Información del Prospecto
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Prospecto: ",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        "${prospecto.nombre} ${prospecto.apellidoPaterno} ${prospecto.apellidoMaterno}",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: separation),
                            Text(
                              prospecto.telefono,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyMedium,
                            ),
                            Text(
                              prospecto.correo,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyMedium,
                            ),
                            SizedBox(height: separation),
                            const Divider(),

                            // Información de la Cita

                            SizedBox(height: separation),

                            Text(
                              cita.descripcion.isEmpty
                                  ? "Sin descripción."
                                  : cita.descripcion,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyMedium,
                            ),
                            SizedBox(
                              height: separation,
                            ),
                            Text(
                              "Programada para el ${cita.fecha ?? 'Fecha no especificada'} a las ${cita.hora}",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List<dynamic>> getData() async {
    final ProspectoService prospectoService = ProspectoService();
    final CitaService citaService = CitaService();

    return await Future.wait([
      prospectoService.getProspecto(appointmentID),
      citaService.getCita(appointmentID),
    ]);
  }
}
