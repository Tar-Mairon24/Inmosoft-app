import 'package:flutter/material.dart';
import 'package:frontend/domain/models/contrato_modelo.dart';
import 'package:frontend/domain/models/propiedad_menu_modelo.dart';
import 'package:frontend/presentation/navigator_key.dart';
import 'package:frontend/presentation/providers/agreements_notifier.dart';
import 'package:frontend/presentation/widgets/add_pdf_agreement_widget.dart';
import 'package:frontend/services/contrato_service.dart';
import 'package:frontend/services/propiedad_service.dart';
import 'package:provider/provider.dart';

class AgreementAdderPage extends StatefulWidget {
  const AgreementAdderPage({super.key});

  @override
  State<AgreementAdderPage> createState() => _AgreementAdderPageState();
}

class _AgreementAdderPageState extends State<AgreementAdderPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController propertyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double separation = MediaQuery.of(context).size.height * 0.02;
    List<Widget> agreements = [
      AddAgreementWidget(),
    ];
    PropiedadService propiedadService = PropiedadService();
    int idPropiedad = 0;
    String tipoContrato = '';

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
                  return agreements[i];
                },
                separatorBuilder: (context, i) => SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                itemCount: agreements.length,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Expanded(
                flex: 2,
                child: FutureBuilder(
                    future: propiedadService.getAllPropiedades(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text("error: ${snapshot.error.toString()}"));
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      List<PropiedadMenu>? propiedades = snapshot.data!.data;
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  customTextFormFieldWidget(
                                      titleController, 'Título'),
                                  SizedBox(
                                    height: separation,
                                  ),
                                  TextFormField(
                                    controller: descriptionController,
                                    decoration: InputDecoration(
                                      labelText: 'Descripción',
                                      border: OutlineInputBorder(),
                                    ),
                                    maxLines: 3,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Este campo es obligatorio';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: separation,
                                  ),
                                  DropdownMenu(
                                    width: double.infinity,
                                    label: const Text("Tipo de contrato"),
                                    dropdownMenuEntries: [
                                      DropdownMenuEntry(
                                          value: 'Compraventa',
                                          label: "Compraventa"),
                                      DropdownMenuEntry(
                                          value: 'Arrendamiento',
                                          label: "Arrendamiento"),
                                    ],
                                    onSelected: (value) {
                                      tipoContrato = value!;
                                    },
                                  ),
                                  SizedBox(
                                    height: separation,
                                  ),
                                  DropdownMenu(
                                    width: double.infinity,
                                    label: const Text("Propiedad asociada"),
                                    dropdownMenuEntries:
                                        propiedades!.map((propiedad) {
                                      return DropdownMenuEntry(
                                          value: propiedad.idPropiedad,
                                          label: propiedad.titulo);
                                    }).toList(),
                                    onSelected: (value) {
                                      idPropiedad = value!;
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: FilledButton(
                      onPressed: () async {
                        Contrato contrato = Contrato(
                            idContrato: 0,
                            tituloContrato: titleController.text,
                            descripcionContrato: descriptionController.text,
                            tipo: tipoContrato,
                            idPropiedad: idPropiedad);

                        ContratoService contratoService = ContratoService();
                        await contratoService.createContrato(contrato);

                        Provider.of<AgreementsNotifier>(
                                navigatorKey.currentContext!,
                                listen: false)
                            .shouldRefresh();
                        Navigator.of(context).pop();
                      },
                      child: Text('Agregar contrato')),
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
}
