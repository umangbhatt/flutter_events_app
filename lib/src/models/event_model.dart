import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EventModel {
  String eventId;
  String eventName;
  String eventType;
  String description;
  String eventLocation;
  DateTime createdAt;
  DateTime eventTime;

  EventModel(
      {this.eventId,
      this.eventName,
      this.eventType,
      this.description,
      this.eventLocation,
      this.eventTime,
      this.createdAt});

  String dateString() {
    DateFormat dateFormat = DateFormat('EEE, MMMM dd, yyyy').add_jm();
    return dateFormat.format(eventTime);
  }

  EventModel.fromJSON(Map<String, dynamic> data)
      : eventId = data['id'] ?? '',
        eventName = data['name']?? '',
        eventType = data['type']?? '',
        description = data['description']?? '',
        eventLocation = data['location']?? '',
        eventTime = (data['time'] as Timestamp).toDate(),
        createdAt = data['createdAt'] == null
            ? null
            : (data['createdAt'] as Timestamp).toDate();

  Map<String, dynamic> toJSON() {
    return {
      'id': this.eventId,
      'name': this.eventName,
      'type': this.eventType,
      'description': this.description,
      'location': this.eventLocation,
      'time': Timestamp.fromDate(this.eventTime),
      'createdAt': (this.createdAt != null)
          ? Timestamp.fromDate(this.createdAt)
          : FieldValue.serverTimestamp()
    };
  }
}
