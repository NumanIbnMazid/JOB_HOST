part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileFetchInProgress extends UserProfileState {}

class UserProfileFetchSuccess extends UserProfileState {
  final Map profileData;

  const UserProfileFetchSuccess({@required this.profileData});

  @override
  List<Object> get props => [profileData];

  @override
  String toString() => "UserProfileFetchSuccess { profileData: $profileData }";
}

class UserProfileFetchFailure extends UserProfileState {
  final String error;

  const UserProfileFetchFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => "UserProfileFetchFailure { error: $error }";
}

class UserProfileUpdateInProgress extends UserProfileState {}

class UserProfileUpdateFailure extends UserProfileState {
  final String error;

  const UserProfileUpdateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => "UserProfileUpdateFailure { error: $error }";
}
