import 'package:events_app/src/services/login_service.dart';
import 'package:events_app/src/utils/locator.dart';
import 'package:events_app/src/utils/routes.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(onPressed: ()async{
          await serviceLocator<LoginService>().signOut();
          Navigator.of(context).pushReplacementNamed(login);
        }, child: Text('Sign out')),
      ),
    );
  }
}