import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/add_pdf_agreement_widget.dart';

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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          customTextFormFieldWidget(titleController, 'Título'),
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
                          customTextFormFieldWidget(
                              typeController, 'Tipo de contrato'),
                          SizedBox(
                            height: separation,
                          ),
                          customTextFormFieldWidget(
                              propertyController, 'Propiedad correspondiente')
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: FilledButton(
                              onPressed: () {},
                              child: Text('Agregar contrato')),
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
