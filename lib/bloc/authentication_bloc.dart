import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:task_project/repositories/firebase_auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuthRepository _firebaseAuthRepository;
  AuthenticationBloc(this._firebaseAuthRepository)
      : super(const AuthenticationState()) {
    on<AuthenticationEvent>((event, emit) {});
    on<AuthenticationLogin>(loginEvent);
    on<AuthenticationRegister>(registerEvent);
  }

  Future<FutureOr<void>> loginEvent(
      AuthenticationLogin event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: AuthenticationStatus.loading));
      await _firebaseAuthRepository.signInWithEmailAndPassword(
          email: event.email, password: event.password);

      emit(state.copyWith(status: AuthenticationStatus.authenticated));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          errorMessage: e.message ?? ''));
    } catch (e) {
      emit(state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> registerEvent(
      AuthenticationRegister event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: AuthenticationStatus.loading));
      await _firebaseAuthRepository.createUserWithEmailAndPassword(
          email: event.email, password: event.password);

      emit(state.copyWith(status: AuthenticationStatus.authenticated));
      emit(state.copyWith(status: AuthenticationStatus.authenticated));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          errorMessage: e.toString()));
    }
  }
}
