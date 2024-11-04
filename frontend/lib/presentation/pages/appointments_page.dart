import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/appointment_widget.dart';
import 'package:frontend/presentation/widgets/appointments_calendar_widget.dart';
import 'package:frontend/presentation/widgets/navigation_drawer_widget.dart';
import 'package:frontend/services/cita_service.dart';
import 'package:frontend/models/citas_modelo.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
   final CitaService citaService = CitaService();
  List<Widget> appointments = [];

  @override
  void initState() {
    super.initState();
    getCitasUser();
  }

  void getCitasUser() async {
    final result = await citaService.getAllCitasUser(1);

    if (result.success) {
      final citas = result.data;
      final appointments = createAppointmentWidgets(citas ?? []);
      setState(() {
        this.appointments = appointments;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            result.errorMessage ?? 'Checar la conexion con el servidor',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  List<Widget> createAppointmentWidgets(List<CitaMenu> citas) {
    return citas.map((cita) {
      return AppointmentWidget(
        title: cita.titulo,
        name: cita.nombre + cita.apellidoPaterno + cita.apellidoMaterno,
        fecha: cita.fecha,
        hour: cita.hora,
      );
    }).toList();
  }

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
                  onPressed: () {},
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
