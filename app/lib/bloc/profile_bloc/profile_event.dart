import 'package:app/model/user_data_model.dart';

abstract class ProfileEvent {}

class ProfileFetchingEvent extends ProfileEvent {}

class ProfileEditEvent extends ProfileEvent {
  final UserDataModel user;

  ProfileEditEvent({required this.user});
}
