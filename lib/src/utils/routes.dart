import 'package:events_app/src/ui/events/add_event_screen.dart';
import 'package:events_app/src/ui/events/event_details_screen.dart';
import 'package:events_app/src/ui/events/events_screen.dart';
import 'package:events_app/src/ui/home/home_screen.dart';
import 'package:events_app/src/ui/login/login_screen.dart';
import 'package:flutter/material.dart';

const String login = "Login";
const String events = 'Events';
const String eventDetails = 'EventDetails';
const String addNewEvent = 'AddNewEvent';
const String home = 'Home';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_)=>HomeScreen());
      case events:
        return MaterialPageRoute(builder: (_) => EventsScreen());
      case addNewEvent:
      return MaterialPageRoute(builder: (_)=>AddEventScreen(eventToEdit: settings.arguments,));  
      case eventDetails:
      return MaterialPageRoute(builder: (_)=>EventDetailsScreen(settings.arguments));
      default:
      return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
