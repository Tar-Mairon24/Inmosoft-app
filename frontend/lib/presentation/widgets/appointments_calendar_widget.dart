// import 'package:flutter/material.dart';
// import 'package:frontend/services/cita_service.dart';
// import 'package:table_calendar/table_calendar.dart';

// class AppointmentsCalendarWidget extends StatefulWidget {
//   const AppointmentsCalendarWidget({super.key});

//   @override
//   State<AppointmentsCalendarWidget> createState() =>
//       _AppointmentsCalendarWidgetState();
// }

// class _AppointmentsCalendarWidgetState
//     extends State<AppointmentsCalendarWidget> {
//   final CitaService citaService = CitaService();

//   List<Widget> appointments = [];
//   List<DateTime> _appointmentDates = [];

//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return TableCalendar(
//       headerStyle: HeaderStyle(formatButtonVisible: false),
//       rowHeight: MediaQuery.of(context).size.height * 0.1,
//       focusedDay: _focusedDay,
//       calendarFormat: _calendarFormat,
//       firstDay: DateTime.utc(2010),
//       lastDay: DateTime.utc(2040),
//       // onPageChanged: (focusedDay) {
//       //   setState(() {
//       //     _focusedDay = focusedDay;
//       //     _selectedMonth = focusedDay.month;
//       //   });

//       //   Provider.of<AppointmentsNotifier>(
//       //           navigatorKey.currentContext!,
//       //           listen: false)
//       //       .shouldRefresh();
//       // },
//       selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//       onDaySelected: (selectedDay, focusedDay) {
//         setState(() {
//           _selectedDay = selectedDay;
//           _focusedDay = focusedDay;
//         });
//         Provider.of<AppointmentsNotifier>(navigatorKey.currentContext!,
//                 listen: false)
//             .shouldRefresh();
//       },
//       calendarBuilders: CalendarBuilders(
//         // Decorador personalizado para los días con citas
//         defaultBuilder: (context, day, focusedDay) {
//           if (_appointmentDates
//               .any((appointmentDate) => isSameDay(appointmentDate, day))) {
//             return Container(
//               decoration: BoxDecoration(
//                 color: Colors.redAccent.withOpacity(0.8),
//                 shape: BoxShape.circle,
//               ),
//               margin: EdgeInsets.all(6.0),
//               alignment: Alignment.center,
//               child: Text(
//                 '${day.day}',
//                 style: TextStyle(color: Colors.white),
//               ),
//             );
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }
