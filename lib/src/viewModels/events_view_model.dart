import 'dart:async';

import 'package:events_app/src/models/event_model.dart';
import 'package:events_app/src/repository/events_repository.dart';
import 'package:events_app/src/utils/locator.dart';
import 'package:flutter/material.dart';

class EventsViewModel extends ChangeNotifier {
  List<EventModel> eventsList;
  final EventsRepository eventsRepository = serviceLocator<EventsRepository>();
  StreamSubscription<List<EventModel>> eventsListener;

  void getEventsList() {
    try {
      eventsList = [];
      eventsListener = eventsRepository.getEventsStream().listen((eventsList) {
        this.eventsList.clear();
        this.eventsList.addAll(eventsList);
        notifyListeners();
      });
    } catch (e) {
      throw e;
    }
  }

  Future addNewEvent(EventModel model) async {
    try {
      return eventsRepository.addNewEvent(model);
    } catch (e) {
      throw e;
    }
  }
  Future updateEvent(EventModel model) async {
    try {
      return eventsRepository.updateEvent(model);
    } catch (e) {
      throw e;
    }
  }

  Future deleteEvent(String eventId) async {
    try {
      return eventsRepository.deleteEvent(eventId);
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    eventsListener.cancel();
    super.dispose();
  }
}
