import 'package:flutter/material.dart';

class HomeFiltersBarWidget extends StatefulWidget {
  const HomeFiltersBarWidget({super.key});

  @override
  State<HomeFiltersBarWidget> createState() => _HomeFiltersBarWidgetState();
}

class _HomeFiltersBarWidgetState extends State<HomeFiltersBarWidget> {
  bool filterByPrice = false;
  bool filterByLocation = false;
  bool filterByBedrooms = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.attach_money_outlined),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          "Precio",
                          style: Theme.of(context).primaryTextTheme.bodyMedium,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Switch(
                          value: filterByPrice,
                          onChanged: (value) {
                            setState(() {
                              filterByPrice = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.location_on_outlined),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          "Locación",
                          style: Theme.of(context).primaryTextTheme.bodyMedium,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Switch(
                          value: filterByLocation,
                          onChanged: (value) {
                            setState(() {
                              filterByLocation = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.bed_outlined),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          "Habitaciones",
                          style: Theme.of(context).primaryTextTheme.bodyMedium,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Switch(
                          value: filterByBedrooms,
                          onChanged: (value) {
                            setState(() {
                              filterByBedrooms = value;
                            });
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
    );
  }
}
