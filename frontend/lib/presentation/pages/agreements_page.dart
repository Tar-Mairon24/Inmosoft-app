import 'package:flutter/material.dart';
import 'package:frontend/domain/models/contrato_modelo.dart';
import 'package:frontend/presentation/pages/agreement_adder_page.dart';
import 'package:frontend/presentation/providers/agreements_notifier.dart';
import 'package:frontend/presentation/widgets/agreement_widget.dart';
import 'package:frontend/presentation/widgets/navigation_drawer_widget.dart';
import 'package:provider/provider.dart';

class AgreementsPage extends StatelessWidget {
  const AgreementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contratos',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02),
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => AgreementAdderPage()),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                        vertical: MediaQuery.of(context).size.height * 0.018,
                      ),
                      child: Text('Nuevo contrato'),
                    ),
                  ),
                ),
              ),
              Divider(),
              Expanded(child: Consumer<AgreementsNotifier>(
                  builder: (context, agreementsNotifier, child) {
                return FutureBuilder(
                  future: agreementsNotifier.loadData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Text("Error: ${snapshot.error.toString()}"));
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<ContratoMenu>? contratos = snapshot.data!.data;

                    // Si contratos es null o está vacío, mostrar un mensaje en lugar del listado
                    if (contratos == null || contratos.isEmpty) {
                      return Center(
                        child: Text("No hay contratos aún"),
                      );
                    }

                    return ListView.separated(
                      itemBuilder: (context, i) {
                        return AgreementWidget(
                          contrato: contratos[i],
                        );
                      },
                      separatorBuilder: (context, i) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      itemCount: contratos.length,
                    );
                  },
                );
              })),
            ],
          )),
      drawer: NavigationDrawerWidget(),
    );
  }
}
