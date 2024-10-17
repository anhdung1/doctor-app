abstract class LoginEvent {}

class LoginCheckEvent extends LoginEvent {
  final String username;
  final String password;

  LoginCheckEvent({
    required this.username,
    required this.password,
  });
}

class ShowSignUpPageEvent extends LoginEvent {}
