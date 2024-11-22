import 'package:flutter/material.dart';
import 'package:frontend/domain/models/citas_modelo.dart';
import 'package:frontend/domain/models/propietario_modelo.dart';
import 'package:frontend/domain/models/prospecto_modelo.dart';
import 'package:frontend/presentation/navigator_key.dart';
import 'package:frontend/presentation/providers/appointments_notifier.dart';
import 'package:frontend/presentation/widgets/add_appointment_image_widget.dart';
import 'package:frontend/services/cita_service.dart';
import 'package:frontend/services/prospecto_service.dart';
import 'package:provider/provider.dart';

class AppointmentAdderPage extends StatefulWidget {
  const AppointmentAdderPage({super.key});

  @override
  State<AppointmentAdderPage> createState() => _AppointmentAdderPageState();
}

class _AppointmentAdderPageState extends State<AppointmentAdderPage> {
  final _formKey = GlobalKey<FormState>();

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
    final CitaService citaService = CitaService();
    final ProspectoService prospectoService = ProspectoService();
    double separation = MediaQuery.of(context).size.height * 0.02;
    List<Widget> images = [
      AddAppointmentImageWidget(),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return images[i];
                },
                separatorBuilder: (context, i) => SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                itemCount: images.length,
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
                      customTextFormFieldWidget(hourController, 'Hora (hh:mm)'),
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
                      customTextFormFieldWidget(emailController, "Email"),
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
                        Cita cita = Cita(
                          id: 0,
                          titulo: titleController.text,
                          fecha: null,
                          hora: int.parse(hourController.text),
                          descripcion: descriptionController.text,
                          idUsuario: 1,
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
