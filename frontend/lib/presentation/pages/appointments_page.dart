import 'package:flutter/material.dart';
import 'package:frontend/presentation/navigator_key.dart';
import 'package:frontend/presentation/pages/appointment_adder_page.dart';
import 'package:frontend/presentation/providers/appointments_notifier.dart';
import 'package:frontend/presentation/providers/auth_provider.dart';
import 'package:frontend/presentation/widgets/appointment_widget.dart';
import 'package:frontend/presentation/widgets/appointments_calendar_widget.dart';
import 'package:frontend/presentation/widgets/navigation_drawer_widget.dart';
import 'package:frontend/services/cita_service.dart';
import 'package:frontend/domain/models/citas_modelo.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  final CitaService citaService = CitaService();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  int _selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                child: FilledButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AppointmentAdderPage(
                            day: _selectedDay,
                          ))),
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
            Divider(),
            Expanded(
              child: Row(
                children: [
                  // Primer Expanded con Consumer y FutureBuilder
                  Expanded(
                    flex: 1,
                    child: Consumer<AppointmentsNotifier>(
                      builder:
                          (BuildContext context, appointmentsNotifier, child) {
                        return FutureBuilder(
                          future: appointmentsNotifier.loadDataByDate(
                            authProvider.userId!,
                            _selectedDay!.toIso8601String().split('T')[0],
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                      "error: ${snapshot.error.toString()}"));
                            }
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            List<Image> images = [
                              Image.asset(
                                  'assets/images/prospects/images1.jpg'),
                              Image.asset(
                                  'assets/images/prospects/images2.jpeg'),
                              Image.asset(
                                  'assets/images/prospects/images3.jpeg'),
                              Image.asset(
                                  'assets/images/prospects/images4.jpeg'),
                              Image.asset(
                                  'assets/images/prospects/images5.jpeg'),
                              Image.asset(
                                  'assets/images/prospects/images6.jpg'),
                            ];
                            List<CitaMenu>? appointments = snapshot.data!.data;

                            if (appointments!.isEmpty) {
                              return Center(
                                child: Text("No hay citas"),
                              );
                            } else {
                              return ListView.separated(
                                itemCount: appointments.length,
                                itemBuilder: (context, i) {
                                  return AppointmentWidget(
                                    image: images[i],
                                    appointment: appointments[i],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),

                  // Segundo Expanded con TableCalendar fuera del FutureBuilder
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.06,
                  ),
                  Expanded(
                      flex: 1,
                      child: FutureBuilder(
                          future:
                              citaService.getAllCitasUser(authProvider.userId!),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                      "error: ${snapshot.error.toString()}"));
                            }
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            List<DateTime> appointmentDates = [];

                            appointmentDates = snapshot.data!.data!
                                .map((cita) => DateTime.parse(cita.fecha))
                                .toList();
                            return TableCalendar(
                              headerStyle:
                                  HeaderStyle(formatButtonVisible: false),
                              rowHeight:
                                  MediaQuery.of(context).size.height * 0.1,
                              focusedDay: _focusedDay,
                              calendarFormat: _calendarFormat,
                              firstDay: DateTime.utc(2010),
                              lastDay: DateTime.utc(2040),
                              selectedDayPredicate: (day) =>
                                  isSameDay(_selectedDay, day),
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                                Provider.of<AppointmentsNotifier>(
                                        navigatorKey.currentContext!,
                                        listen: false)
                                    .shouldRefresh();
                              },
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, day, focusedDay) {
                                  if (appointmentDates.any((appointmentDate) =>
                                      isSameDay(appointmentDate, day))) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.redAccent.withOpacity(0.8),
                                        shape: BoxShape.circle,
                                      ),
                                      margin: EdgeInsets.all(6.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${day.day}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }
                                  return null;
                                },
                              ),
                            );
                          })),
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
