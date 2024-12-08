import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/domain/models/citas_modelo.dart';
import 'package:frontend/domain/models/imagen_prospecto_modelo.dart';
import 'package:frontend/domain/models/prospecto_modelo.dart';
import 'package:frontend/services/cita_service.dart';
import 'package:frontend/services/imagen_prospecto_service.dart';
import 'package:frontend/services/prospecto_service.dart';

class DetailedAppointmentPage extends StatelessWidget {
  const DetailedAppointmentPage(
      {super.key, required this.appointmentID, required this.image});
  final int appointmentID;
  final Image image;

  @override
  Widget build(BuildContext context) {
    ImagenProspectoService imagenProspectoService = ImagenProspectoService();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.aspectRatio * 14),
        child: Center(
          child: Row(
            children: [
              FutureBuilder(
                  future:
                      imagenProspectoService.getImagenPrincipal(appointmentID),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error.toString()}"),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    ImagenProspecto? image = snapshot.data!.data;

                    return Expanded(
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.aspectRatio * 102,
                        backgroundColor: Colors.grey[400],
                        backgroundImage: FileImage(File(image!
                            .rutaImagen)), // Use FileImage instead of Image.file
                      ),
                    );
                  }),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
              ),
              FutureBuilder(
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
                    double separation =
                        MediaQuery.of(context).size.height * 0.02;

                    return Expanded(
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
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
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
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyMedium,
                              ),
                              Text(
                                prospecto.correo,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyMedium,
                              ),
                              SizedBox(height: separation),
                              const Divider(),

                              // Información de la Cita

                              SizedBox(height: separation),

                              Text(
                                cita.descripcion.isEmpty
                                    ? "Sin descripción."
                                    : cita.descripcion,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyMedium,
                              ),
                              SizedBox(
                                height: separation,
                              ),
                              Text(
                                "Programada para el ${cita.fecha ?? 'Fecha no especificada'} a las ${formatHora(cita.hora)}",
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
                    );
                  })
            ],
          ),
        ),
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

  String formatHora(int hora) {
    String horaStr = hora.toString();
    if (horaStr.length == 3) {
      // Para las horas en formato de tres dígitos, agregamos el cero inicial
      return "0${horaStr.substring(0, 1)}:${horaStr.substring(1)}";
    } else if (horaStr.length == 4) {
      // Para las horas en formato de cuatro dígitos (hhmm)
      return "${horaStr.substring(0, 2)}:${horaStr.substring(2)}";
    } else {
      // Si la hora no tiene el formato esperado, devolverla tal cual
      return horaStr;
    }
  }
}
