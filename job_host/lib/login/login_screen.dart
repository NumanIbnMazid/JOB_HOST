import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_host/authentication/authentication.dart';
import 'package:job_host/login/bloc/login_bloc.dart';
import 'package:job_host/login/login_form.dart';
import 'package:job_host/repositories/user_repository.dart';
import 'package:job_host/widgets/authentication/authentication_switch.dart';

class LoginPage extends StatelessWidget {
  final Function toggleView;
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository, this.toggleView})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              LoginForm(),
              SizedBox(height: 15),
              AuthenticationSwitch(
                toggleView: toggleView,
                title: "Login",
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user-profile');
                },
                child: Text("My Profile"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
