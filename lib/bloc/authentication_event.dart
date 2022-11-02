part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationInitial extends AuthenticationEvent {}

class AuthenticationLogin extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationLogin({required this.email, required this.password});
}

class AuthenticationRegister extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationRegister({required this.email, required this.password});
}
