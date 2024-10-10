abstract class SignupEvent {}

class SignUpCheckEvent extends SignupEvent {
  final String username;
  final String password;
  final bool agreeCondition;
  final String reEnterPassword;

  SignUpCheckEvent({
    required this.username,
    required this.password,
    required this.reEnterPassword,
    required this.agreeCondition,
  });
}

class SignUpUpgradeErrorEvent extends SignupEvent {
  final String error;

  SignUpUpgradeErrorEvent({required this.error});
}

class ShowLoginEvent extends SignupEvent {}

class SendSignUpEvent extends SignupEvent {
  final String username;
  final String password;

  SendSignUpEvent({required this.username, required this.password});
}

class BackSignUpEvent extends SignupEvent {}
