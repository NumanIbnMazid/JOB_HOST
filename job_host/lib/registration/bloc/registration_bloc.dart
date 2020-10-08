import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_host/repositories/user_repository.dart';
import 'package:job_host/authentication/authentication.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegistrationBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(RegistrationInitial());

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationButtonPressed) {
      yield RegistrationInProgress();

      try {
        final Map responseData = await userRepository.registration(
          username: event.username,
          email: event.email,
          accountType: event.accountType,
          password1: event.password1,
          password2: event.password2,
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
        yield RegistrationInitial();
      } catch (error) {
        yield RegistrationFailure(error: error.toString());
      }
    }

    // Username field on changed
    if (event is RegistrationFormFieldOnChanged) {
      yield RegistrationBlank();
      final Map responseData = await userRepository.formFieldValidation(
        fieldName: event.fieldName,
        fieldValue: event.fieldValue,
        requiredField: event.requiredField,
        modelName: event.modelName,
        searchType: event.searchType,
      );
      // print(
      //     "bloc : registration_bloc => 63 (responseData : mapEventToState()) => $responseData");
      try {
        final String message = responseData['message'];
        final bool status = responseData['status'];
        yield RegistrationFormFieldValidation(
          fieldName: event.fieldName,
          message: message,
          status: status,
          requiredField: event.requiredField,
        );
        // yield RegistrationBlank();
      } catch (error) {
        yield RegistrationFormFieldValidation(
          fieldName: event.fieldName,
          message: event.requiredField == true
              ? "${event.fieldName} is required"
              : "",
          status: false,
          requiredField: event.requiredField,
        );
      }
    }
  }
}
