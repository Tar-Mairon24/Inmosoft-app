import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/home_filters_bar_widget.dart';
import 'package:frontend/presentation/widgets/navigation_drawer_widget.dart';

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
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06),
        child: Column(
          children: [
            HomeFiltersBarWidget(),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.06,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.06,
                crossAxisCount: 4,
                children: properties,
              ),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawerWidget(),
    );
  }
}
