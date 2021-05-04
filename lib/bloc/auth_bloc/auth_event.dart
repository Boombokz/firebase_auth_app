part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class InitialEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterEvent({required this.email, required this.password});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RecoveryPasswordEvent extends AuthEvent {
  final String email;

  RecoveryPasswordEvent({required this.email});
}

class ChangePasswordEvent extends AuthEvent {
  final String newPassword;

  ChangePasswordEvent({
    required this.newPassword,
  });
}

class LoginWithFacebookEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}
