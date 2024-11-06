import 'package:flutter/material.dart';
import 'package:frontend/models/estado_propiedad_modelo.dart';
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
  final TextEditingController observationsController = TextEditingController();

  bool isOccupied = false;
  bool isFurnished = false;
  bool hasClima = false;
  bool hasCalefaccion = false;
  bool hasHidroneumatico = false;
  bool hasAljibe = false;
  bool hasTinaco = false;
  bool hasAgua = false;
  bool hasLuz = false;
  bool hasInternet = false;
  bool isGasEstacionario = false;
  bool isGasNatural = false;
  bool hasAlberca = false;
  bool hasJardin = false;
  bool hasTechada = false;
  bool hasCocineta = false;
  bool hasCuartoServicio = false;
  List<String> gases = [];
  List<String> comodidades = [];
  List<String> utilidades = [];
  List<String> extras = [];

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
            observationsController.text = property.observaciones;

            List<String> gases = property.gas;
            List<String> comodidades = property.comodidades;
            List<String> utilidades = property.utilidades;
            List<String> extras = property.extras;
            isOccupied = false;
            isFurnished = false;
            hasClima = comodidades.contains("clima") ? true : false;
            hasCalefaccion = comodidades.contains("calefacción") ? true : false;
            hasHidroneumatico =
                comodidades.contains("hidroneumático") ? true : false;
            hasAljibe = comodidades.contains("aljibe") ? true : false;
            hasTinaco = comodidades.contains("tinaco") ? true : false;
            hasAgua = utilidades.contains("agua") ? true : false;
            hasLuz = utilidades.contains("luz") ? true : false;
            hasInternet = utilidades.contains("internet") ? true : false;
            isGasEstacionario =
                gases.contains("gas estacionario") ? true : false;
            isGasNatural = gases.contains("gas natural") ? true : false;
            hasAlberca = extras.contains("alberca") ? true : false;
            hasJardin = extras.contains("jardín") ? true : false;
            hasTechada = extras.contains("techada") ? true : false;
            hasCocineta = extras.contains("cocineta") ? true : false;
            hasCuartoServicio =
                extras.contains("cuarto de servicio") ? true : false;

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
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
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
                                  customNumberFormFieldWidget(
                                      priceController, 'precio'),
                                  SizedBox(height: separation),
                                  customNumberFormFieldWidget(
                                      constrMtsController,
                                      'metros de la construcción'),
                                  SizedBox(height: separation),
                                  customNumberFormFieldWidget(
                                      lotMtsController, 'metros del terreno'),
                                  SizedBox(height: separation),
                                  customNumberFormFieldWidget(
                                      floorsNumController, 'número de plantas'),
                                  SizedBox(height: separation),
                                  customNumberFormFieldWidget(
                                      bedroomsNumController,
                                      'número de recámaras'),
                                  SizedBox(height: separation),
                                  customNumberFormFieldWidget(
                                      bathroomsNumController,
                                      'número de baños'),
                                  SizedBox(height: separation),
                                  customNumberFormFieldWidget(
                                      garageSizeController,
                                      'tamaño de la cochera'),
                                  SizedBox(height: separation),
                                  customNumberFormFieldWidget(
                                      gardenMtsController, 'metros del jardín'),
                                  SizedBox(height: separation),
                                  TextFormField(
                                    maxLines: 3,
                                    controller: observationsController,
                                    decoration: InputDecoration(
                                      labelText: "observaciones",
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Este campo es obligatorio';
                                      }
                                      return null;
                                    },
                                  ),
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
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("General")),
                                        Divider(),
                                        customSwitchWidget(
                                            "Habitada", isOccupied, (newValue) {
                                          setState(() {
                                            isOccupied = newValue;
                                          });
                                        }),
                                        customSwitchWidget(
                                            "Amueblada", isFurnished,
                                            (newValue) {
                                          setState(() {
                                            isFurnished = newValue;
                                          });
                                        }),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Comodidades")),
                                        Divider(),
                                        customSwitchWidget("Clima", hasClima,
                                            (newValue) {
                                          setState(() {
                                            hasClima = newValue;
                                          });
                                        }),
                                        customSwitchWidget(
                                            "Calefacción", hasCalefaccion,
                                            (newValue) {
                                          setState(() {
                                            hasCalefaccion = newValue;
                                          });
                                        }),
                                        customSwitchWidget(
                                            "Hidroneúmatico", hasHidroneumatico,
                                            (newValue) {
                                          setState(() {
                                            hasHidroneumatico = newValue;
                                          });
                                        }),
                                        customSwitchWidget("Aljibe", hasAljibe,
                                            (newValue) {
                                          setState(() {
                                            hasAljibe = newValue;
                                          });
                                        }),
                                        customSwitchWidget("Tinaco", hasTinaco,
                                            (newValue) {
                                          setState(() {
                                            hasTinaco = newValue;
                                          });
                                        }),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Utilidades")),
                                        Divider(),
                                        customSwitchWidget("Agua", hasAgua,
                                            (newValue) {
                                          setState(() {
                                            hasAgua = newValue;
                                          });
                                        }),
                                        customSwitchWidget("Luz", hasLuz,
                                            (newValue) {
                                          setState(() {
                                            hasLuz = newValue;
                                          });
                                        }),
                                        customSwitchWidget(
                                            "Internet", hasInternet,
                                            (newValue) {
                                          setState(() {
                                            hasInternet = newValue;
                                          });
                                        }),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Gas")),
                                        Divider(),
                                        customSwitchWidget(
                                            "Natural", isGasNatural,
                                            (newValue) {
                                          setState(() {
                                            isGasNatural = newValue;
                                          });
                                        }),
                                        customSwitchWidget(
                                            "Estacionario", isGasEstacionario,
                                            (newValue) {
                                          setState(() {
                                            isGasEstacionario = newValue;
                                          });
                                        }),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Extras")),
                                        Divider(),
                                        customSwitchWidget(
                                            "Alberca", hasAlberca, (newValue) {
                                          setState(() {
                                            hasAlberca = newValue;
                                          });
                                        }),
                                        customSwitchWidget("Jardín", hasJardin,
                                            (newValue) {
                                          setState(() {
                                            hasJardin = newValue;
                                          });
                                        }),
                                        customSwitchWidget(
                                            "Techada", hasTechada, (newValue) {
                                          setState(() {
                                            hasTechada = newValue;
                                          });
                                        }),
                                        customSwitchWidget(
                                            "Cocineta", hasCocineta,
                                            (newValue) {
                                          setState(() {
                                            hasCocineta = newValue;
                                          });
                                        }),
                                        customSwitchWidget("Cuarto de servicio",
                                            hasCuartoServicio, (newValue) {
                                          setState(() {
                                            hasCuartoServicio = newValue;
                                          });
                                        })
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
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (hasClima) {
                                              comodidades.add("clima");
                                            }
                                            if (hasCalefaccion) {
                                              comodidades.add("calefacción");
                                            }
                                            if (hasHidroneumatico) {
                                              comodidades.add("aljibe");
                                            }
                                            if (hasTinaco) {
                                              comodidades.add("tinaco");
                                            }
                                            if (hasAgua) {
                                              utilidades.add("agua");
                                            }
                                            if (hasLuz) {
                                              utilidades.add("luz");
                                            }
                                            if (hasInternet) {
                                              utilidades.add("internet");
                                            }
                                            if (isGasNatural) {
                                              gases.add("natural");
                                            }
                                            if (isGasEstacionario) {
                                              gases.add("estacionario");
                                            }
                                            if (hasAlberca) {
                                              extras.add("jardin");
                                            }
                                            if (hasTechada) {
                                              extras.add("techada");
                                            }
                                            if (hasCocineta) {
                                              extras.add("cocineta");
                                            }
                                            if (hasCuartoServicio) {
                                              extras.add("cuarto_servicio");
                                            }

                                            String formattedDate =
                                                DateTime.now()
                                                    .toString()
                                                    .split(' ')[0];

                                            Propiedad propiedad = Propiedad(
                                              idPropiedad: 0,
                                              titulo: titleController.text,
                                              fechaAlta: formattedDate,
                                              direccion: addressController.text,
                                              colonia: residenceController.text,
                                              ciudad: cityController.text,
                                              referencia:
                                                  referenceController.text,
                                              precio: double.parse(
                                                  priceController.text),
                                              mtsConstruccion: int.parse(
                                                  constrMtsController.text),
                                              mtsTerreno: int.parse(
                                                  lotMtsController.text),
                                              habitada: isOccupied,
                                              amueblada: isFurnished,
                                              numPlantas: int.parse(
                                                  floorsNumController.text),
                                              numRecamaras: int.parse(
                                                  bedroomsNumController.text),
                                              numBanos: int.parse(
                                                  bathroomsNumController.text),
                                              sizeCochera: int.parse(
                                                  garageSizeController.text),
                                              mtsJardin: int.parse(
                                                  gardenMtsController.text),
                                              gas: gases,
                                              comodidades: comodidades,
                                              extras: extras,
                                              utilidades: utilidades,
                                              observaciones:
                                                  observationsController.text,
                                              idTipoPropiedad: 1,
                                              idPropietario: 1,
                                              idUsuario: 2,
                                            );

                                            EstadoPropiedad estadoPropiedad =
                                                EstadoPropiedad(
                                              idEstadoPropiedad: 0,
                                              tipoTransaccion: "renta",
                                              estado: "disponible",
                                              fechaCambioEstado: null,
                                              idPropiedad: 0,
                                            );

                                            Navigator.of(context).pop();
                                          }
                                        },
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
