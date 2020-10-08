import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_host/repositories/user_profile_repository.dart';
import 'package:job_host/repositories/user_repository.dart';
import 'package:job_host/shared/appDrawer.dart';
import 'package:job_host/shared/loggedInCheckWrapper.dart';
import 'package:job_host/userProfile/bloc/user_profile_bloc.dart';
import 'package:job_host/userProfile/user_profile_details_screen.dart';

class UserProfilePage extends StatelessWidget {
  final UserRepository userRepository;
  final UserProfileRepository userProfileRepository;

  UserProfilePage({
    Key key,
    @required this.userRepository,
    @required this.userProfileRepository,
  })  : assert(userRepository != null),
        assert(userProfileRepository != null),
        super(key: key);

  // UserProfilePage({
  //   @required this.userRepository,
  //   @required this.userProfileRepository,
  // });

  @override
  Widget build(BuildContext context) {
    return LoggedInCheckWrapper(
      userRepository: userRepository,
      scaffold: Scaffold(
        appBar: AppBar(
          title: Text('My Profile'),
          centerTitle: true,
        ),
        drawer: appDrawer(context),
        body: BlocProvider(
          create: (context) {
            return UserProfileBloc(
              userProfileRepository: userProfileRepository,
              userRepository: userRepository,
            );
          },
          child: Column(
            children: [
              Expanded(
                child: UserProfileDetailsPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
