import 'package:flutter/material.dart';

class AuthenticationSwitch extends StatelessWidget {
  final Function toggleView;
  final String title;
  AuthenticationSwitch({this.toggleView, this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toggleView();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7),
        padding: EdgeInsets.all(13),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title == "Registration"
                  ? 'Already have an account ?'
                  : "Don't have an account ?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title == "Login" ? "Register" : "Login",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
