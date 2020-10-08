import 'dart:async';
import 'package:job_host/repositories/user_profile_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_host/repositories/user_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository userRepository;
  final UserProfileRepository userProfileRepository;

  UserProfileBloc({
    @required this.userRepository,
    @required this.userProfileRepository,
  })  : assert(userRepository != null),
        assert(userProfileRepository != null),
        super(UserProfileInitial());

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is UserProfileFetchEvent) {
      yield UserProfileFetchInProgress();

      try {
        final Map storageData = await userRepository.getStorageData();

        // print(
        //     "userProfile : userProfileBLoc => 35 (storageData : mapEventToState()) => $storageData");

        final String token = storageData['token'];
        final String profileSlug = storageData['profileSlug'];

        final Map userProfileData = await userProfileRepository.getUserProfile(
          profileSlug: profileSlug,
          token: token,
        );

        yield UserProfileFetchSuccess(profileData: userProfileData);
      } catch (error) {
        yield UserProfileFetchFailure(error: error.toString());
      }
    }
  }
}
