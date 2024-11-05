import 'package:flutter/material.dart';
import 'package:frontend/models/estado_propiedad_modelo.dart';
import 'package:frontend/models/propiedad_modelo.dart';
import 'package:frontend/presentation/navigator_key.dart';
import 'package:frontend/presentation/providers/properties_notifier.dart';
import 'package:frontend/presentation/widgets/add_photo_widget.dart';
import 'package:frontend/services/estado_propiedad_service.dart';
import 'package:frontend/services/propiedad_service.dart';
import 'package:provider/provider.dart';

class PropertyAdderPage extends StatefulWidget {
  const PropertyAdderPage({super.key});

  @override
  State<PropertyAdderPage> createState() => _PropertyAdderPageState();
}

class _PropertyAdderPageState extends State<PropertyAdderPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController residenceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController constrMtsController = TextEditingController();
  final TextEditingController lotMtsController = TextEditingController();
  final TextEditingController floorsNumController = TextEditingController();
  final TextEditingController bedroomsNumController = TextEditingController();
  final TextEditingController bathroomsNumController = TextEditingController();
  final TextEditingController garageSizeController = TextEditingController();
  final TextEditingController gardenMtsController = TextEditingController();
  final TextEditingController observationsController = TextEditingController();

  bool isOccupied = false;
  bool isFurnished = false;

  @override
  Widget build(BuildContext context) {
    final PropiedadService propiedadService = PropiedadService();
    final EstadoPropiedadService estadoPropiedadService =
        EstadoPropiedadService();
    double separation = MediaQuery.of(context).size.height * 0.02;
    List<Widget> photos = [
      AddPhotoWidget(),
    ];

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
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return photos[i];
                },
                separatorBuilder: (context, i) => SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                itemCount: photos.length,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Expanded(
              flex: 2,
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            customTextFormFieldWidget(
                                titleController, 'título'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                addressController, 'dirección'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                residenceController, 'colonia'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(cityController, 'ciudad'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                referenceController, 'referencia'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                priceController, 'precio'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(constrMtsController,
                                'metros de la construcción'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                lotMtsController, 'metros del terreno'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                floorsNumController, 'número de plantas'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                bedroomsNumController, 'número de recámaras'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                bathroomsNumController, 'número de baños'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                garageSizeController, 'tamaño de la cochera'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                gardenMtsController, 'metros del jardín'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                observationsController, 'observaciones'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  customSwitchWidget("Habitada", isOccupied,
                                      (newValue) {
                                    setState(() {
                                      isOccupied = newValue;
                                    });
                                  }),
                                  customSwitchWidget("Amueblada", isFurnished,
                                      (newValue) {
                                    setState(() {
                                      isFurnished = newValue;
                                    });
                                  }),
                                  // customSwitchWidget("Clima", (value) {}),
                                  // customSwitchWidget("Calefacción", (value) {}),
                                  // customSwitchWidget(
                                  //     "Hidroneumático", (value) {}),
                                  // customSwitchWidget("Aljibe", (value) {}),
                                  // customSwitchWidget("Tinaco", (value) {}),
                                  // customSwitchWidget("Alberca", (value) {}),
                                  // customSwitchWidget("Jardín", (value) {}),
                                  // customSwitchWidget("Techada", (value) {}),
                                  // customSwitchWidget("Cocineta", (value) {}),
                                  // customSwitchWidget(
                                  //     "Cuarto de servicio", (value) {}),
                                  // customSwitchWidget("Agua", (value) {}),
                                  // customSwitchWidget("Luz", (value) {}),
                                  // customSwitchWidget("Internet", (value) {}),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.02),
                            child: SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                  onPressed: () async {
                                    Propiedad propiedad = Propiedad(
                                      idPropiedad: 0,
                                      titulo: titleController.text,
                                      fechaAlta: "2024-11-4",
                                      direccion: addressController.text,
                                      colonia: residenceController.text,
                                      ciudad: cityController.text,
                                      referencia: referenceController.text,
                                      precio:
                                          double.parse(priceController.text),
                                      mtsConstruccion:
                                          int.parse(constrMtsController.text),
                                      mtsTerreno:
                                          int.parse(lotMtsController.text),
                                      habitada: isOccupied,
                                      amueblada: isFurnished,
                                      numPlantas:
                                          int.parse(floorsNumController.text),
                                      numRecamaras:
                                          int.parse(bedroomsNumController.text),
                                      numBanos: int.parse(
                                          bathroomsNumController.text),
                                      sizeCochera:
                                          int.parse(garageSizeController.text),
                                      mtsJardin:
                                          int.parse(gardenMtsController.text),
                                      gas: ["natural"],
                                      comodidades: ["clima", "aljibe"],
                                      extras: ["alberca", "jardin", "techada"],
                                      utilidades: ["agua", "luz", "internet"],
                                      observaciones:
                                          observationsController.text,
                                      idTipoPropiedad: 1,
                                      idPropietario: 1,
                                      idUsuario: 2,
                                    );
                                    EstadoPropiedad estadoPropiedad =
                                        EstadoPropiedad(
                                      idEstadoPropiedad: 0,
                                      tipoTransaccion: "'renta'",
                                      estado: "disponible",
                                      fechaCambioEstado: null,
                                      idPropiedad: 0,
                                    );

                                    await propiedadService.insertPropiedad(
                                        propiedad, estadoPropiedad);
                                    Provider.of<PropertiesNotifier>(
                                            navigatorKey.currentContext!,
                                            listen: false)
                                        .shouldRefresh();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Agregar propiedad')),
                            ),
                          ),
                        ],
                      ),
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

  Widget customSwitchWidget(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).primaryTextTheme.bodyMedium,
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
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
}
