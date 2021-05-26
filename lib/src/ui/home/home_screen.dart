import 'package:events_app/src/ui/events/events_screen.dart';
import 'package:events_app/src/ui/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle: true,
          flexibleSpace: SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TabBar(
                tabs: [Container(
                  padding: EdgeInsets.all(8),
                  child: Text('Events')), Container(
                    padding: EdgeInsets.all(8),
                    child: Text('Settings'))],
                onTap: (value) {
                  setState(() {
                    selectedTab = value;
                  });
                },
              ),
            ),
          ),
        ),
        body: TabBarView(children: [
          EventsScreen(),
          SettingsScreen(),
        ]),
      ),
    );
  }
}
