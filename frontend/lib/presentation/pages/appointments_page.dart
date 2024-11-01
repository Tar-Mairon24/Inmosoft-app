import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/appointment_adder_page.dart';
import 'package:frontend/presentation/widgets/appointment_widget.dart';
import 'package:frontend/presentation/widgets/appointments_calendar_widget.dart';
import 'package:frontend/presentation/widgets/navigation_drawer_widget.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  List<Widget> appointments = [
    AppointmentWidget(
      title: 'Cita con Lupita',
      name: 'Guadalupe Martínez',
      hour: '15:00',
    ),
    AppointmentWidget(
      title: 'Cita con Lupita',
      name: 'Guadalupe Martínez',
      hour: '15:00',
    ),
    AppointmentWidget(
      title: 'Cita con Lupita',
      name: 'Guadalupe Martínez',
      hour: '15:00',
    ),
    AppointmentWidget(
      title: 'Cita con Lupita',
      name: 'Guadalupe Martínez',
      hour: '15:00',
    ),
    AppointmentWidget(
      title: 'Cita con Lupita',
      name: 'Guadalupe Martínez',
      hour: '15:00',
    ),
    AppointmentWidget(
      title: 'Cita con Lupita',
      name: 'Guadalupe Martínez',
      hour: '15:00',
    ),
    AppointmentWidget(
      title: 'Cita con Lupita',
      name: 'Guadalupe Martínez',
      hour: '15:00',
    ),
    AppointmentWidget(
      title: 'Cita con Lupita',
      name: 'Guadalupe Martínez',
      hour: '15:00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citas'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
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
                      builder: (context) => AppointmentAdderPage(),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                      vertical: MediaQuery.of(context).size.height * 0.018,
                    ),
                    child: Text('Agendar cita'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView.separated(
                      itemCount: appointments.length,
                      itemBuilder: (context, i) {
                        return appointments[i];
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.06,
                  ),
                  Expanded(
                    flex: 1,
                    child: AppointmentsCalendarWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawerWidget(),
    );
  }
}
