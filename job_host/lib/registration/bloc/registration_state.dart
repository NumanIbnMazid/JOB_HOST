part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationBlank extends RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationFormFieldValidation extends RegistrationState {
  final String fieldName;
  final String message;
  final bool status;
  final bool requiredField;

  const RegistrationFormFieldValidation({
    @required this.fieldName,
    @required this.message,
    @required this.status,
    @required this.requiredField,
  });

  @override
  List<Object> get props => [fieldName, message, status, requiredField];

  @override
  String toString() => '$message';
}

class RegistrationInProgress extends RegistrationState {}

class RegistrationFailure extends RegistrationState {
  final String error;

  const RegistrationFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RegistrationFailure { error: $error }';
}
