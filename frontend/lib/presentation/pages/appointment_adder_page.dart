import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/domain/models/citas_modelo.dart';
import 'package:frontend/domain/models/imagen_modelo.dart';
import 'package:frontend/domain/models/imagen_prospecto_modelo.dart';
import 'package:frontend/domain/models/propietario_modelo.dart';
import 'package:frontend/domain/models/prospecto_modelo.dart';
import 'package:frontend/presentation/navigator_key.dart';
import 'package:frontend/presentation/providers/appointments_notifier.dart';
import 'package:frontend/presentation/providers/auth_provider.dart';
import 'package:frontend/presentation/providers/images_notifier.dart';
import 'package:frontend/presentation/widgets/add_appointment_image_widget.dart';
import 'package:frontend/presentation/widgets/prospect_images_row.dart';
import 'package:frontend/services/cita_service.dart';
import 'package:frontend/services/imagen_prospecto_service.dart';
import 'package:frontend/services/imagen_service.dart';
import 'package:frontend/services/prospecto_service.dart';
import 'package:provider/provider.dart';

class AppointmentAdderPage extends StatefulWidget {
  const AppointmentAdderPage({super.key, required this.day});
  final DateTime day;

  @override
  State<AppointmentAdderPage> createState() => _AppointmentAdderPageState();
}

class _AppointmentAdderPageState extends State<AppointmentAdderPage> {
  final _formKey = GlobalKey<FormState>();
  List<String> rutasImagenes = [];
  void _updatePhotos(List<String> updatedPhotos) {
    setState(() {
      rutasImagenes = updatedPhotos;
    });
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController apellidoPaternoController =
      TextEditingController();
  final TextEditingController apellidoMaternoController =
      TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ImagenProspectoService imagenService = ImagenProspectoService();
    final authProvider = Provider.of<AuthProvider>(context);
    final CitaService citaService = CitaService();
    final ProspectoService prospectoService = ProspectoService();
    double separation = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ProspectImagesRow(
                onPhotosUpdated: _updatePhotos,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Datos de la cita")),
                      Divider(),
                      customTextFormFieldWidget(titleController, 'Título'),
                      SizedBox(height: separation),
                      TextFormField(
                        maxLines: 3,
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Descripción',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: separation),
                      //customTextFormFieldWidget(hourController, 'Hora (hh:mm)'),
                      TextFormField(
                        controller: hourController,
                        decoration: InputDecoration(
                          labelText: 'Hora (hh:mm)',
                          border: OutlineInputBorder(),
                          hintText: 'Ej. 14:30',
                        ),
                        keyboardType: TextInputType.datetime,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Datos del prospecto")),
                      Divider(),
                      customTextFormFieldWidget(nameController, "Nombre"),
                      SizedBox(height: separation),
                      customTextFormFieldWidget(
                          apellidoPaternoController, "Apellido paterno"),
                      SizedBox(height: separation),
                      customTextFormFieldWidget(
                          apellidoMaternoController, "Apellido materno"),
                      SizedBox(height: separation),
                      customTextFormFieldWidget(phoneNumController, "Teléfono"),
                      SizedBox(height: separation),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa un correo electrónico';
                          }
                          // Expresión regular para validar email
                          final RegExp emailRegex =
                              RegExp(r'^\w+[\w-\.]*\@\w+((\.\w+)+)$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Por favor, ingresa un correo válido';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: FilledButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Elimina el ":" de la hora antes de convertirla en número
                        String horaSinDosPuntos =
                            hourController.text.replaceAll(":", "");

                        // Ahora puedes convertir la hora sin el ":"
                        Cita cita = Cita(
                          id: 0,
                          titulo: titleController.text,
                          fecha: widget.day.toIso8601String().split('T')[0],
                          hora: int.parse(
                              horaSinDosPuntos), // Convierte a entero sin los ":"
                          descripcion: descriptionController.text,
                          idUsuario: authProvider.userId!,
                          idCliente: 0,
                        );

                        Prospecto prospecto = Prospecto(
                            idCliente: 0,
                            nombre: nameController.text,
                            apellidoPaterno: apellidoPaternoController.text,
                            apellidoMaterno: apellidoMaternoController.text,
                            telefono: phoneNumController.text,
                            correo: emailController.text);

                        await prospectoService.createProspecto(prospecto);
                        await citaService.createCita(cita);

                        bool isFirst = true;
                        for (String ruta in rutasImagenes) {
                          print(rutasImagenes);
                          ImagenProspecto imagen = ImagenProspecto(
                            idImagen: 0,
                            rutaImagen: ruta,
                            descripcion: null,
                            principal: isFirst, // True para el primer elemento
                            idProspecto: 0,
                          );

                          await imagenService.insertImagen(imagen);

                          isFirst =
                              false; // Después del primer elemento, todos serán false
                        }

                        Provider.of<ImagesNotifier>(
                                navigatorKey.currentContext!,
                                listen: false)
                            .shouldRefresh();
                        Provider.of<AppointmentsNotifier>(
                                navigatorKey.currentContext!,
                                listen: false)
                            .shouldRefresh();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Agendar cita'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextFormFieldWidget(
      TextEditingController controller, String? labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        return null;
      },
    );
  }

  Widget customNumberFormFieldWidget(
      TextEditingController controller, String? labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        if (int.tryParse(value) == null) {
          return 'Solo se permiten números';
        }
        return null;
      },
    );
  }
}
