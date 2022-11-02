part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, loading, unauthenticated }

class AuthenticationState extends Equatable {
  const AuthenticationState(
      {this.status = AuthenticationStatus.unknown,
      this.user,
      this.errorMessage});
  final User? user;
  final AuthenticationStatus status;
  final String? errorMessage;
  @override
  // TODO: implement props
  List<Object?> get props => [user, status, errorMessage];

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthenticationState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
