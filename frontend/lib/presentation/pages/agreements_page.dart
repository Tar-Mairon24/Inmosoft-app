import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/agreement_adder_page.dart';
import 'package:frontend/presentation/widgets/agreement_widget.dart';
import 'package:frontend/presentation/widgets/navigation_drawer_widget.dart';

class AgreementsPage extends StatelessWidget {
  const AgreementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> agreements = [
      AgreementWidget(
          type: 'Arrendamiento',
          title: 'Arrendamiento de Lupita',
          property: 'Casa de Ramos',
          client: 'Guadalupe'),
      AgreementWidget(
          type: 'Arrendamiento',
          title: 'Arrendamiento de Lupita',
          property: 'Casa de Ramos',
          client: 'Guadalupe'),
      AgreementWidget(
          type: 'Arrendamiento',
          title: 'Arrendamiento de Lupita',
          property: 'Casa de Ramos',
          client: 'Guadalupe'),
      AgreementWidget(
          type: 'Arrendamiento',
          title: 'Arrendamiento de Lupita',
          property: 'Casa de Ramos',
          client: 'Guadalupe'),
      AgreementWidget(
          type: 'Arrendamiento',
          title: 'Arrendamiento de Lupita',
          property: 'Casa de Ramos',
          client: 'Guadalupe'),
      AgreementWidget(
          type: 'Arrendamiento',
          title: 'Arrendamiento de Lupita',
          property: 'Casa de Ramos',
          client: 'Guadalupe'),
    ];
    if (agreements.isEmpty) {
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
                      onPressed: () {},
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
                Expanded(
                  child: Center(
                    child: Text("No existen contratos aún"),
                  ),
                ),
              ],
            )),
        drawer: NavigationDrawerWidget(),
      );
    } else {
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
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, i) {
                        return agreements[i];
                      },
                      separatorBuilder: (context, i) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                      itemCount: agreements.length),
                ),
              ],
            )),
        drawer: NavigationDrawerWidget(),
      );
    }
  }
}
