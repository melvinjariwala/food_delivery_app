// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:food_delivery_app/repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription? _userSubscription;
  AuthenticationBloc(
      {required AuthenticationRepository authenticaitonRepository})
      : _authenticationRepository = authenticaitonRepository,
        super(authenticaitonRepository.currentUser.isNotEmpty
            ? AuthenticationState.authenticated(
                authenticaitonRepository.currentUser)
            : const AuthenticationState.unauthenticated()) {
    on<AuthenticationUserChanged>(authenticationUserChanged);
    on<AuthenticationLogoutRequest>(authenticationLogoutRequest);

    _userSubscription = _authenticationRepository.user
        .listen((user) => add(AuthenticationUserChanged(user)));
  }

  FutureOr<void> authenticationUserChanged(
      AuthenticationUserChanged event, Emitter<AuthenticationState> emit) {
    emit(event.user.isNotEmpty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated());
  }

  FutureOr<void> authenticationLogoutRequest(
      AuthenticationLogoutRequest event, Emitter<AuthenticationState> emit) {
    unawaited(_authenticationRepository.logout());
  }

  @override
  Future<void> close() async {
    _userSubscription?.cancel();
    return super.close();
  }
}
