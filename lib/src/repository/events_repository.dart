import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/src/models/event_model.dart';
import 'package:events_app/src/utils/constants.dart';

class EventsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<EventModel>> getEventsStream() {
    try {
      StreamController eventsStream =
          StreamController<List<EventModel>>.broadcast();
      StreamSubscription firestoreListener = _firestore
          .collection(Constants.eventsCollection)
          .orderBy('time')
          .snapshots()
          
          .listen((querySnapshot) {
        eventsStream.add(querySnapshot.docs
            .map<EventModel>((doc) => EventModel.fromJSON(doc.data()))
            .toList());
      }, onDone: () {
        eventsStream.close();
      }, onError: (error) {
        eventsStream.addError(error);
      });

      eventsStream.onCancel = () => firestoreListener.cancel();

      return eventsStream.stream;
    } catch (e) {
      print('error from getEventsStream in events repository $e');
      throw e;
    }
  }

  Future addNewEvent(EventModel eventModel) async {
    try {
      DocumentReference eventDocRef =
          _firestore.collection(Constants.eventsCollection).doc();
      eventModel.eventId = eventDocRef.id;
      return eventDocRef.set(eventModel.toJSON());
    } catch (e) {
      print('error from addNewEvent in events repository $e');
      throw e;
    }
  }

  Future deleteEvent(String eventId) async {
    try {
      return _firestore
          .collection(Constants.eventsCollection)
          .doc(eventId)
          .delete();
    } catch (e) {
      print('error from deleteEvent in events repository $e');
      throw e;
    }
  }

  Future updateEvent(EventModel eventModel) async {
    try {
      return _firestore
          .collection(Constants.eventsCollection)
          .doc(eventModel.eventId)
          .set(eventModel.toJSON());
    } catch (e) {
      print('error from updateEvent in events repository $e');
      throw e;
    }
  }
}
