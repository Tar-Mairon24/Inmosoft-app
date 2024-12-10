import 'package:flutter/material.dart';
import 'package:frontend/domain/models/propiedad_menu_modelo.dart';
import 'package:frontend/presentation/navigator_key.dart';
import 'package:frontend/presentation/providers/properties_notifier.dart';
import 'package:frontend/presentation/widgets/add_property_widget.dart';
import 'package:frontend/presentation/widgets/navigation_drawer_widget.dart';
import 'package:frontend/presentation/widgets/property_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool filterByPrice = false;
  bool filterByBedrooms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Propiedades',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06,
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.04),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.filter_list_outlined),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              "Filtros",
                              style:
                                  Theme.of(context).primaryTextTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Icon(Icons.attach_money_outlined),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Text(
                                  "Precio",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyMedium,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Switch(
                                  value: filterByPrice,
                                  onChanged: (value) {
                                    setState(() {
                                      filterByPrice = value;
                                    });
                                    Provider.of<PropertiesNotifier>(
                                            navigatorKey.currentContext!,
                                            listen: false)
                                        .shouldRefresh();
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Icon(Icons.bed_outlined),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Text(
                                  "Habitaciones",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyMedium,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Switch(
                                  value: filterByBedrooms,
                                  onChanged: (value) {
                                    setState(() {
                                      filterByBedrooms = value;
                                    });
                                    Provider.of<PropertiesNotifier>(
                                            navigatorKey.currentContext!,
                                            listen: false)
                                        .shouldRefresh();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            Consumer(builder: (BuildContext context,
                PropertiesNotifier propertiesNotifier, Widget? child) {
              futureData() {
                if (filterByPrice) {
                  return propertiesNotifier.loadDataByPrice();
                } else if (filterByBedrooms) {
                  return propertiesNotifier.loadDataByBedrooms();
                } else {
                  return propertiesNotifier.loadData();
                }
              }

              return FutureBuilder(
                  future: futureData(),
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

                    return Expanded(
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
                    );
                  });
            }),
          ],
        ),
      ),
      drawer: NavigationDrawerWidget(),
    );
  }
}
