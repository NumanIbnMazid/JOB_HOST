import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_host/authentication/authentication.dart';
import 'package:job_host/login/login_screen.dart';
import 'package:job_host/registration/registration_screen.dart';
import 'package:job_host/repositories/user_profile_repository.dart';
import 'package:job_host/repositories/user_repository.dart';
import 'package:job_host/screens/wrapper.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_host/userProfile/user_profile_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class JobHostBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  await GetStorage.init("JobHostStorage");
  Bloc.observer = JobHostBlocObserver();
  final userRepository = UserRepository();
  final userProfileRepository = UserProfileRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AuthenticationStarted());
      },
      child: App(
        userRepository: userRepository,
        userProfileRepository: userProfileRepository,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final UserProfileRepository userProfileRepository;

  App({
    Key key,
    @required this.userRepository,
    @required this.userProfileRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Wrapper(userRepository: userRepository),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('en', 'US'),
      supportedLocales: [
        const Locale('en', 'US'), // English
      ],
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Wrapper(userRepository: userRepository),
        '/login': (BuildContext context) =>
            LoginPage(userRepository: userRepository),
        '/registration': (BuildContext context) =>
            RegistrationPage(userRepository: userRepository),
        '/user-profile': (BuildContext context) => UserProfilePage(
              userRepository: userRepository,
              userProfileRepository: userProfileRepository,
            ),
      },
    );
  }
}
