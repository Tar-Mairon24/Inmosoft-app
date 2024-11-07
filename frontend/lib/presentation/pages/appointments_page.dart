import 'package:flutter/material.dart';
import 'package:frontend/presentation/providers/appointments_notifier.dart';
import 'package:frontend/presentation/widgets/appointment_widget.dart';
import 'package:frontend/presentation/widgets/appointments_calendar_widget.dart';
import 'package:frontend/presentation/widgets/navigation_drawer_widget.dart';
import 'package:frontend/services/cita_service.dart';
import 'package:frontend/models/citas_modelo.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citas'),
      ),
      body: Consumer(builder: (BuildContext context,
          AppointmentsNotifier appointmentsNotifier, Widget? child) {
        return FutureBuilder(
            future: appointmentsNotifier.loadData(1),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text("error: ${snapshot.error.toString()}"));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              List<Image> images = [
                Image.asset('assets/images/prospects/images1.jpg'),
                Image.asset('assets/images/prospects/images2.jpeg'),
                Image.asset('assets/images/prospects/images3.jpeg'),
                Image.asset('assets/images/prospects/images4.jpeg'),
                Image.asset('assets/images/prospects/images5.jpeg'),
                Image.asset('assets/images/prospects/images6.jpg'),
              ];
              List<CitaMenu>? appointments = snapshot.data!.data;

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.02),
                        child: FilledButton(
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.04,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.018,
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
                              itemCount: appointments!.length,
                              itemBuilder: (context, i) {
                                return AppointmentWidget(
                                  image: images[i],
                                  appointment: appointments[i],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
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
              );
            });
      }),
      drawer: NavigationDrawerWidget(),
    );
  }
}
