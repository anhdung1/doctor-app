import 'package:app/layers/presentation/blocs/appointment_bloc/appointment_bloc.dart';
import 'package:app/layers/presentation/blocs/appointment_bloc/appointment_event.dart';
import 'package:app/layers/domain/entities/doctor_data_model.dart';
import 'package:app/layers/domain/entities/doctors_dto_data_model.dart';
import 'package:app/layers/presentation/blocs/appointment_bloc/appointment_state.dart';
import 'package:app/layers/presentation/views/chat/chat_screen.dart';
import 'package:app/layers/presentation/views/constants/variable.dart';
import 'package:app/layers/presentation/views/widgets/app_bar.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectTime extends StatelessWidget {
  final DoctorsDtoDataModel doctorsDTO;
  const SelectTime({super.key, required this.doctorsDTO});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentBloc()
        ..add(AppointmentStartedEvent(doctorId: doctorsDTO.doctors.id)),
      child: SelectTimePage(doctorsDTO: doctorsDTO),
    );
  }
}

class SelectTimePage extends StatefulWidget {
  const SelectTimePage({super.key, required this.doctorsDTO});
  final DoctorsDtoDataModel doctorsDTO;

  @override
  State<SelectTimePage> createState() => _SelectTimePageState();
}

class _SelectTimePageState extends State<SelectTimePage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: homeTheme,
        height: screenHeight,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              appBar(context, "Select Time"),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 90,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 1)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    widget.doctorsDTO.doctors.image,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.account_circle,
                                        size: 87,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.doctorsDTO.doctors.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    widget.doctorsDTO.doctors.category,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green[500],
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: RatingBar.readOnly(
                                        initialRating:
                                            widget.doctorsDTO.doctors.rate,
                                        filledIcon: Icons.star,
                                        size: 11,
                                        emptyIcon: Icons.star_outline_outlined),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(top: 1),
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                    onTap: () {
                                      DoctorDataModel doctor =
                                          widget.doctorsDTO.doctors;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChatScreen(receiver: doctor),
                                          ));
                                    },
                                    child: const Icon(
                                      Icons.message,
                                      color: Colors.black54,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocConsumer<AppointmentBloc, AppointmentState>(
                builder: (context, state) {
                  DateTime dateTime = DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day);
                  if (state is AppointmentSuccessState) {
                    for (int i = 0; i < state.appointments.length; i++) {
                      print(dateTime == state.appointments[i].appointmentDate);
                    }
                  }
                  return date(() {});
                },
                listener: (context, state) {},
              )
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            setState(() {
              List<DateTime> dates = [
                DateTime(2024, 11, 1),
                DateTime(2024, 11, 5),
                DateTime(2024, 10, 20),
                DateTime(2024, 12, 10),
              ];
              DateTime minDate = dates.reduce((a, b) => a.isBefore(b) ? a : b);
              DateTime maxDate = dates.reduce((a, b) => a.isAfter(b) ? a : b);
              DateTime nextMinDAte = minDate.add(Duration(days: 1));
              int differenceInDays = maxDate.difference(minDate).inDays;
              print(minDate);
              print(nextMinDAte == minDate.add(Duration(days: 1)));
            });
          },
          child: Icon(Icons.refresh)),
    );
  }

  listDate() {
    return ListView.builder(
      itemBuilder: (context, index) {},
    );
  }

  date(onTap) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 130,
          height: 54,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.black26, width: 0.3),
              color: Colors.transparent),
          // child: Column(
          //   children: [Text(data)],
          // ),
        ),
      ),
    );
  }
}
