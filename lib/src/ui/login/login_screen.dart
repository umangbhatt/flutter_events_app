import 'package:events_app/src/services/login_service.dart';
import 'package:events_app/src/utils/constants.dart';
import 'package:events_app/src/utils/locator.dart';
import 'package:events_app/src/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginService _loginService = serviceLocator<LoginService>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !isLoading? TextButton(
            onPressed: () async {
              try {
                setState(() {
                  isLoading = true;
                });
                await _loginService.signIn();
                Navigator.of(context).pushReplacementNamed(home);
              
              } catch (e) {
                Fluttertoast.showToast(msg: 'Some error occured! Try again');
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: Text('Sign In')):CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
