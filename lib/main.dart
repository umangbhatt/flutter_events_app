import 'package:events_app/src/services/login_service.dart';
import 'package:events_app/src/utils/locator.dart';
import 'package:events_app/src/utils/routes.dart';
import 'package:events_app/src/viewModels/events_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => EventsViewModel())],
      child: MaterialApp(
        title: 'Events App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Routes.generateRoute,
        initialRoute:
            serviceLocator<LoginService>().isUserSignedIn() ? home : login,
      ),
    );
  }
}
