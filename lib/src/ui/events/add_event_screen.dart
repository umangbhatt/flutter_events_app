import 'package:events_app/src/models/event_model.dart';
import 'package:events_app/src/utils/constants.dart';
import 'package:events_app/src/viewModels/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  final EventModel eventToEdit;
  AddEventScreen({this.eventToEdit});
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  DateTime eventDateTime;
  List<String> eventTypes = ['Type 1', 'Type 2', 'Type 3'];
  String selectedEventType;

  TextEditingController eventNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  GlobalKey<FormState> eventDetailsFormKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    if (widget.eventToEdit != null) {
      eventNameController.text = widget.eventToEdit.eventName;
      descriptionController.text = widget.eventToEdit.description;
      locationController.text = widget.eventToEdit.eventLocation;
      selectedEventType = widget.eventToEdit.eventType;
      eventDateTime = widget.eventToEdit.eventTime;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.eventToEdit != null ? 'Edit Event' : 'Add New Event'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : eventDetailsForm(),
    );
  }

  Widget eventDetailsForm() {
    DateFormat dateFormat = DateFormat('EEE, MMMM dd, yyyy').add_jm();

    return SafeArea(
      child: Form(
          key: eventDetailsFormKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              TextFormField(
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Event name is required!';
                  } else if (value.trim().length < 3) {
                    return 'Event name is too short!';
                  } else
                    return null;
                },
                controller: eventNameController,
                decoration: InputDecoration(
                    labelText: 'Event Name', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Event description is required!';
                  } else if (value.trim().length < 10) {
                    return 'Event description is too short!';
                  } else
                    return null;
                },
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: 'Description', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Event location is required!';
                  } else if (value.trim().length < 3) {
                    return 'Event location is too short!';
                  } else
                    return null;
                },
                controller: locationController,
                decoration: InputDecoration(
                    labelText: 'Event Location', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                onTap: () async {
                  DateTime date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)));
                  if (date != null) {
                    TimeOfDay time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (time != null)
                      setState(() {
                        this.eventDateTime = DateTime(date.year, date.month,
                            date.day, time.hour, time.minute);
                      });
                  }
                },
                title: Text((eventDateTime != null)
                    ? dateFormat.format(eventDateTime)
                    : 'Event Time'),
              ),
              SizedBox(
                height: 16,
              ),
              DropdownButton(
                  underline: Container(),
                  hint: Text('Event Type'),
                  value: selectedEventType,
                  onChanged: (value) {
                    setState(() {
                      this.selectedEventType = value;
                    });
                  },
                  items: eventTypes
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList()),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (eventDetailsFormKey.currentState.validate()) {
                    if (eventDateTime == null) {
                      Fluttertoast.showToast(
                          msg: 'Please select event date and time');
                    } else if (selectedEventType == null) {
                      Fluttertoast.showToast(
                          msg: 'Please select event type');
                    } else {
                      try {
                        setState(() {
                          isLoading = true;
                        });

                        EventModel eventModel = EventModel(
                            eventId: widget.eventToEdit != null
                                ? widget.eventToEdit.eventId
                                : null,
                            eventName: eventNameController.text.trim(),
                            description: descriptionController.text.trim(),
                            eventLocation: locationController.text.trim(),
                            eventTime: eventDateTime,
                            eventType: selectedEventType,
                            createdAt: widget.eventToEdit != null
                                ? widget.eventToEdit.createdAt
                                : null);
                        if (widget.eventToEdit != null) {
                          await Provider.of<EventsViewModel>(context,
                                  listen: false)
                              .updateEvent(eventModel);
                          Fluttertoast.showToast(
                              msg: 'Event updated successfully');
                        } else {
                          await Provider.of<EventsViewModel>(context,
                                  listen: false)
                              .addNewEvent(eventModel);
                          Fluttertoast.showToast(
                              msg: 'Event added successfully');
                        }

                        Navigator.of(context).pop();
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: 'Some error occurred! Try again.');
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  }
                },
                child: Text('Submit'),
              )
            ],
          )),
    );
  }
}
