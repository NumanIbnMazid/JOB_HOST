import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_host/authentication/authentication_bloc.dart';
import 'package:job_host/authentication/authentication_state.dart';
import 'package:job_host/repositories/user_repository.dart';
import 'package:job_host/screens/home/home_screen.dart';
import 'package:job_host/screens/splash/splash_screen.dart';
import 'package:job_host/shared/loading.dart';
import 'package:job_host/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  final UserRepository userRepository;
  Wrapper({this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return HomePage();
        }
        if (state is AuthenticationFailure) {
          return Authenticate(userRepository: userRepository);
        }
        if (state is AuthenticationInProgress) {
          return LoadingIndicator();
        }
        return SplashPage();
      },
    );
  }
}
