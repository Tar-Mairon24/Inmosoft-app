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
    List<Widget> photos = [
      AddPhotoWidget(),
      AddPhotoWidget(),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
            vertical: MediaQuery.of(context).size.width * 0.02),
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
                  itemCount: photos.length),
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: titleController,
                              decoration: const InputDecoration(
                                labelText: 'título',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                labelText: 'descripción',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                labelText: 'precio',
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            switchWidget("Cocina", (value) {}),
                            switchWidget("Sala", (value) {}),
                            switchWidget("Comedor", (value) {}),
                            switchWidget("Lavandería", (value) {}),
                            switchWidget("Patio", (value) {}),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Agregar propiedad'),
                              ),
                            ),
                          ],
                        ),
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

  Widget switchWidget(String title, ValueChanged<bool>? onChanged) {
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
}
