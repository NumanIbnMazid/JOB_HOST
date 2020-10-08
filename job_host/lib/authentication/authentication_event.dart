import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {
  @override
  String toString() => 'Authentication Started';
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final String token;
  final int id;
  final int profileID;
  final String profileSlug;

  const AuthenticationLoggedIn(
      {@required this.token, this.id, this.profileID, this.profileSlug});

  @override
  List<Object> get props => [token, id, profileID, profileSlug];
  // List<Object> get props => [token];

  @override
  String toString() => 'Logged In { id: $id }';
}

class AuthenticationLoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'Logged Out';
}
