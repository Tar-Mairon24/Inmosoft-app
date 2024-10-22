import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/appointment_widget.dart';
import 'package:frontend/presentation/widgets/appointments_calendar_widget.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  List<Widget> appointments = [
    AppointmentWidget(
        title: 'Cita de negociación',
        name: 'Rosario Cárdenas Martínez',
        hour: '17:00'),
    AppointmentWidget(
        title: 'Cita de negociación',
        name: 'Rosario Cárdenas Martínez',
        hour: '17:00'),
    AppointmentWidget(
        title: 'Cita de negociación',
        name: 'Rosario Cárdenas Martínez',
        hour: '17:00'),
    AppointmentWidget(
        title: 'Cita de negociación',
        name: 'Rosario Cárdenas Martínez',
        hour: '17:00'),
    AppointmentWidget(
        title: 'Cita de negociación',
        name: 'Rosario Cárdenas Martínez',
        hour: '17:00'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, i) {
                      return appointments[i];
                    },
                    separatorBuilder: (context, i) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                    itemCount: appointments.length),
              ),
              Expanded(child: AppointmentsCalendarWidget())
            ],
          )
        ],
      ),
    );
  }
}
