import 'package:flutter/material.dart';
import 'package:frontend/models/propiedad_modelo.dart';
import 'package:frontend/presentation/widgets/add_photo_widget.dart';
import 'package:frontend/services/propiedad_service.dart';

class PropertyModifierPage extends StatefulWidget {
  const PropertyModifierPage({super.key, required this.propertyID});
  final int propertyID;

  @override
  State<PropertyModifierPage> createState() => _PropertyModifierPageState();
}

class _PropertyModifierPageState extends State<PropertyModifierPage> {
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

  @override
  Widget build(BuildContext context) {
    final PropiedadService propiedadService = PropiedadService();
    double separation = MediaQuery.of(context).size.height * 0.02;
    List<Widget> photos = [
      AddPhotoWidget(),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: propiedadService.getPropiedad(widget.propertyID),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("error: ${snapshot.error.toString()}"));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            Propiedad? property = snapshot.data!.data;

            titleController.text = property!.titulo;
            addressController.text = property.direccion;
            residenceController.text = property.colonia;
            cityController.text = property.ciudad;
            referenceController.text = property.referencia;
            priceController.text = property.precio.toString();
            constrMtsController.text = property.mtsConstruccion.toString();
            lotMtsController.text = property.mtsTerreno.toString();
            floorsNumController.text = property.numPlantas.toString();
            bedroomsNumController.text = property.numRecamaras.toString();
            bathroomsNumController.text = property.numBanos.toString();
            garageSizeController.text = property.sizeCochera.toString();
            gardenMtsController.text = property.mtsJardin.toString();

            return Padding(
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
                                  customTextFormFieldWidget(
                                      cityController, 'ciudad'),
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
                                      bedroomsNumController,
                                      'número de recámaras'),
                                  SizedBox(height: separation),
                                  customTextFormFieldWidget(
                                      bathroomsNumController,
                                      'número de baños'),
                                  SizedBox(height: separation),
                                  customTextFormFieldWidget(
                                      garageSizeController,
                                      'tamaño de la cochera'),
                                  SizedBox(height: separation),
                                  customTextFormFieldWidget(
                                      gardenMtsController, 'metros del jardín'),
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
                                        customSwitchWidget(
                                            "Habitada", (value) {}),
                                        customSwitchWidget(
                                            "Amueblada", (value) {}),
                                        customSwitchWidget("Clima", (value) {}),
                                        customSwitchWidget(
                                            "Calefacción", (value) {}),
                                        customSwitchWidget(
                                            "Hidroneumático", (value) {}),
                                        customSwitchWidget(
                                            "Aljibe", (value) {}),
                                        customSwitchWidget(
                                            "Tinaco", (value) {}),
                                        customSwitchWidget(
                                            "Alberca", (value) {}),
                                        customSwitchWidget(
                                            "Jardín", (value) {}),
                                        customSwitchWidget(
                                            "Techada", (value) {}),
                                        customSwitchWidget(
                                            "Cocineta", (value) {}),
                                        customSwitchWidget(
                                            "Cuarto de servicio", (value) {}),
                                        customSwitchWidget("Agua", (value) {}),
                                        customSwitchWidget("Luz", (value) {}),
                                        customSwitchWidget(
                                            "Internet", (value) {}),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: FilledButton(
                                        onPressed: () {},
                                        child: Text('Guardar cambios')),
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
            );
          }),
    );
  }

  Widget customSwitchWidget(String title, ValueChanged<bool>? onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).primaryTextTheme.bodyMedium,
        ),
        Switch(
          value: false,
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
