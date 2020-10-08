part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();
}

class UserProfileFetchEvent extends UserProfileEvent {
  const UserProfileFetchEvent();

  @override
  List<Object> get props => [];
}
