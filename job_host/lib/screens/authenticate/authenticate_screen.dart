import 'package:job_host/login/login_screen.dart';
import 'package:job_host/registration/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:job_host/repositories/user_repository.dart';

class Authenticate extends StatefulWidget {
  final UserRepository userRepository;
  Authenticate({this.userRepository});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogin = true;

  void toggleView() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showLogin == true
          ? LoginPage(
              toggleView: toggleView,
              userRepository: widget.userRepository,
            )
          : RegistrationPage(
              toggleView: toggleView,
              userRepository: widget.userRepository,
            ),
    );
  }
}
