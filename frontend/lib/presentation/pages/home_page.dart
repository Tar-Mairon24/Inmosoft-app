import 'package:flutter/material.dart';
import 'package:frontend/models/propiedad_menu_modelo.dart';
import 'package:frontend/presentation/providers/properties_notifier.dart';
import 'package:frontend/presentation/widgets/add_property_widget.dart';
import 'package:frontend/presentation/widgets/home_filters_bar_widget.dart';
import 'package:frontend/presentation/widgets/navigation_drawer_widget.dart';
import 'package:frontend/presentation/widgets/property_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              List<Image> images = [
                Image.asset('assets/images/properties/images1.jpeg'),
                Image.asset('assets/images/properties/images2.jpg'),
                Image.asset('assets/images/properties/images3.jpeg'),
                Image.asset('assets/images/properties/images4.jpg'),
                Image.asset('assets/images/properties/images5.jpeg'),
                Image.asset('assets/images/properties/images6.jpeg'),
                Image.asset('assets/images/properties/images1.jpeg'),
                Image.asset('assets/images/properties/images2.jpg'),
                Image.asset('assets/images/properties/images3.jpeg'),
                Image.asset('assets/images/properties/images4.jpg'),
                Image.asset('assets/images/properties/images5.jpeg'),
                Image.asset('assets/images/properties/images6.jpeg'),
              ];
              List<PropiedadMenu>? propiedades = snapshot.data!.data;

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06,
                ),
                child: Column(
                  children: [
                    HomeFiltersBarWidget(),
                    Expanded(
                      child: GridView.builder(
                          itemCount: (propiedades?.length ?? 0) + 1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing:
                                MediaQuery.of(context).size.height * 0.06,
                            crossAxisSpacing:
                                MediaQuery.of(context).size.width * 0.06,
                          ),
                          itemBuilder: (context, i) {
                            if (i == 0) {
                              return AddPropertyWidget();
                            } else {
                              return PropertyWidget(
                                // image: Image.asset('assets/images/images.jpeg'),
                                image: images[i],
                                property: propiedades![i - 1],
                              );
                            }
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
