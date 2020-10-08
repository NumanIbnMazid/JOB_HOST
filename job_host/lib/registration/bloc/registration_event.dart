part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegistrationButtonPressed extends RegistrationEvent {
  final String username;
  final String email;
  final String accountType;
  final String password1;
  final String password2;

  const RegistrationButtonPressed({
    @required this.username,
    @required this.email,
    @required this.accountType,
    @required this.password1,
    @required this.password2,
  });

  @override
  List<Object> get props =>
      [username, email, accountType, password1, password2];

  @override
  String toString() =>
      'RegistrationButtonPressed { username: $username, email: $email, accountType: $accountType, password1: $password1, password2: $password2 }';
}

class RegistrationFormFieldOnChanged extends RegistrationEvent {
  final String fieldName;
  final String fieldValue;
  final bool requiredField;
  final String modelName;
  final String searchType;

  const RegistrationFormFieldOnChanged({
    @required this.fieldName,
    @required this.fieldValue,
    this.requiredField,
    this.modelName,
    this.searchType,
  });

  @override
  List<Object> get props =>
      [fieldName, fieldValue, requiredField, modelName, searchType];

  @override
  String toString() =>
      'RegistrationFormFieldOnChanged { fieldValue: $fieldValue }';
}
