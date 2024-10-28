import 'package:flutter/material.dart';
import 'package:frontend/models/propiedad_menu_modelo.dart';
import 'package:frontend/presentation/providers/properties_notifier.dart';
import 'package:frontend/presentation/widgets/home_filters_bar_widget.dart';
import 'package:frontend/presentation/widgets/navigation_drawer_widget.dart';
import 'package:frontend/presentation/widgets/property_widget.dart';
import 'package:frontend/services/propiedad_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final List<Widget> properties;
  const HomePage({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Propiedades',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Consumer<PropertiesNotifier>(builder: (BuildContext context,
          PropertiesNotifier propertiesNotifier, Widget? child) {
        return FutureBuilder(
            future: propertiesNotifier.loadData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text("error: ${snapshot.error.toString()}"));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              AsyncSnapshot<Result<List<PropiedadMenu>>> resultPropiedades =
                  snapshot;
              List<PropiedadMenu>? propiedades = resultPropiedades.data!.data;
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06,
                ),
                child: Column(
                  children: [
                    HomeFiltersBarWidget(),
                    Expanded(
                      // child: GridView.count(
                      //   crossAxisSpacing:
                      //       MediaQuery.of(context).size.width * 0.06,
                      //   mainAxisSpacing:
                      //       MediaQuery.of(context).size.height * 0.06,
                      //   crossAxisCount: 4,
                      //   children: properties,
                      // ),
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing:
                                MediaQuery.of(context).size.height * 0.06,
                            crossAxisSpacing:
                                MediaQuery.of(context).size.width * 0.06,
                          ),
                          itemBuilder: (context, i) {
                            return PropertyWidget(
                                image: image,
                                title: propiedades[i].titulo,
                                status: propiedades[i].estado,
                                price: propiedades[i].precio);
                          }),
                    ),
                  ],
                ),
              );
            });
      }),
      drawer: NavigationDrawerWidget(),
    );
  }
}

// Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.06,
//         ),
//         child: Column(
//           children: [
//             HomeFiltersBarWidget(),
//             Expanded(
//               child: GridView.count(
//                 crossAxisSpacing: MediaQuery.of(context).size.width * 0.06,
//                 mainAxisSpacing: MediaQuery.of(context).size.height * 0.06,
//                 crossAxisCount: 4,
//                 children: properties,
//               ),
//             ),
//           ],
//         ),
//       ),