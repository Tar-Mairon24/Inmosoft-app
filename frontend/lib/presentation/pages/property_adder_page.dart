import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/presentation/widgets/add_photo_widget.dart';

class PropertyAdderPage extends StatefulWidget {
  const PropertyAdderPage({super.key});

  @override
  State<PropertyAdderPage> createState() => _PropertyAdderPageState();
}

class _PropertyAdderPageState extends State<PropertyAdderPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                                descriptionController, 'dirección'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                priceController, 'colonia'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                priceController, 'ciudad'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                priceController, 'referencia'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                priceController, 'precio'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                priceController, 'metros de la construcción'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                priceController, 'metros del terreno'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                priceController, 'número de plantas'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                priceController, 'número de recámaras'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                priceController, 'número de baños'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                priceController, 'tamaño de la cochera'),
                            SizedBox(height: separation),
                            customTextFormFieldWidget(
                                priceController, 'metros del jardín'),
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
                                  customSwitchWidget("Habitada", (value) {}),
                                  customSwitchWidget("Amueblada", (value) {}),
                                  customSwitchWidget("Clima", (value) {}),
                                  customSwitchWidget("Calefacción", (value) {}),
                                  customSwitchWidget(
                                      "Hidroneumático", (value) {}),
                                  customSwitchWidget("Aljibe", (value) {}),
                                  customSwitchWidget("Tinaco", (value) {}),
                                  customSwitchWidget("Alberca", (value) {}),
                                  customSwitchWidget("Jardín", (value) {}),
                                  customSwitchWidget("Techada", (value) {}),
                                  customSwitchWidget("Cocineta", (value) {}),
                                  customSwitchWidget(
                                      "Cuarto de servicio", (value) {}),
                                  customSwitchWidget("Agua", (value) {}),
                                  customSwitchWidget("Luz", (value) {}),
                                  customSwitchWidget("Internet", (value) {}),
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
                                  onPressed: () {},
                                  child: Text('Agregar propiedad')),
                            ),
                          )
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
