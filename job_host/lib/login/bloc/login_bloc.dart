import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_host/authentication/authentication.dart';
import 'package:meta/meta.dart';
import 'package:job_host/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      try {
        final Map responseData = await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        final String token = responseData['token'];
        final int id = responseData['id'];
        final int profileID = responseData['profileID'];
        final String profileSlug = responseData['profileSlug'];

        authenticationBloc.add(AuthenticationLoggedIn(
          token: token,
          id: id,
          profileID: profileID,
          profileSlug: profileSlug,
        ));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
