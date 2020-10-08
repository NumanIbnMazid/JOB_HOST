import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:job_host/authentication/authentication.dart';
import 'package:meta/meta.dart';
import 'package:job_host/repositories/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      final bool hasToken = await userRepository.hasToken();
      // final bool hasToken = true;
      // print(
      //     "authentication : authentication_bloc => 23 (hasToken : mapEventToState()) => $hasToken");

      if (hasToken) {
        yield AuthenticationSuccess();
      } else {
        yield AuthenticationFailure();
      }
    }

    if (event is AuthenticationLoggedIn) {
      yield AuthenticationInProgress();
      await userRepository.persistToken(
        token: event.token,
        id: event.id,
        profileID: event.profileID,
        profileSlug: event.profileSlug,
      );
      yield AuthenticationSuccess();
    }

    if (event is AuthenticationLoggedOut) {
      yield AuthenticationInProgress();
      await userRepository.deleteToken();
      yield AuthenticationFailure();
    }
  }
}
