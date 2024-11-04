abstract class AppointmentEvent {}

class AppointmentStartedEvent extends AppointmentEvent {
  final int doctorId;

  AppointmentStartedEvent({required this.doctorId});
}

class AppointmentUpdateEvent extends AppointmentEvent {
  final int appointmentId;

  AppointmentUpdateEvent({required this.appointmentId});
}
