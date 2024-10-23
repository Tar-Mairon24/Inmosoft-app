import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsCalendarWidget extends StatefulWidget {
  const AppointmentsCalendarWidget({super.key});

  @override
  State<AppointmentsCalendarWidget> createState() =>
      _AppointmentsCalendarWidgetState();
}

class _AppointmentsCalendarWidgetState
    extends State<AppointmentsCalendarWidget> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerStyle: HeaderStyle(formatButtonVisible: false),
      rowHeight: MediaQuery.of(context).size.height * 0.1,
      focusedDay: today,
      firstDay: DateTime.utc(2010),
      lastDay: DateTime.utc(2040),
      // onDaySelected: ,
      //! Actualizar el estado y traer las citas correspondientes al día seleccionado
    );
  }
}
