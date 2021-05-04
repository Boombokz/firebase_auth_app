part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class RegisteredState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState({required this.errorMessage});
}

class LoggedInState extends AuthState {}

class PasswordRecoveredState extends AuthState{}

class PasswordChangedState extends AuthState{}
