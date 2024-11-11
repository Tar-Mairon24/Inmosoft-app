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
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          headerStyle: HeaderStyle(formatButtonVisible: false),
          rowHeight: MediaQuery.of(context).size.height * 0.1,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          firstDay: DateTime.utc(2010),
          lastDay: DateTime.utc(2040),
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
        ),
      ],
    );
  }
}
