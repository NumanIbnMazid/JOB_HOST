import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_host/authentication/authentication.dart';
import 'package:job_host/registration/bloc/registration_bloc.dart';
import 'package:job_host/registration/registration_form.dart';
import 'package:job_host/repositories/user_repository.dart';
import 'package:job_host/widgets/authentication/authentication_switch.dart';

class RegistrationPage extends StatelessWidget {
  final Function toggleView;
  final UserRepository userRepository;

  RegistrationPage({Key key, @required this.userRepository, this.toggleView})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) {
          return RegistrationBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              RegistrationForm(),
              SizedBox(height: 15),
              AuthenticationSwitch(
                toggleView: toggleView,
                title: "Registration",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
