

import 'package:events_app/src/models/event_model.dart';
import 'package:events_app/src/utils/routes.dart';
import 'package:events_app/src/viewModels/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';



class EventDetailsScreen extends StatelessWidget {
  final EventModel eventModel;
  EventDetailsScreen(this.eventModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: eventDetails(context),
    );
  }

  Widget eventDetails(BuildContext context) {
    
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        widgetWithHeader('Event Name', Text(eventModel.eventName)),
        Divider(),
        widgetWithHeader(
            'Description',
            Text(eventModel.description)),
        Divider(),
        widgetWithHeader('Event Location', Text(eventModel.eventLocation)),
        Divider(),
        widgetWithHeader('Event Type', Text(eventModel.eventType)),
        Divider(),
        widgetWithHeader('Event Time', Text(eventModel.dateString())),
        Divider(),
        SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(addNewEvent, arguments: eventModel);
                },
                icon: Icon(Icons.edit),
                label: Text('Edit')),
            ElevatedButton.icon(
              onPressed: () async {
                bool shouldDelete = await deleteEventConfirmation(context);
                if (shouldDelete != null && shouldDelete) {
                  Provider.of<EventsViewModel>(context, listen: false)
                      .deleteEvent(eventModel.eventId);
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.delete),
              label: Text('Delete'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
            ),
          ],
        )
      ],
    );
  }

  Future<bool> deleteEventConfirmation(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Event?'),
            content: Text(
                'Are you sure you want to delete event ${eventModel.eventName}'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes'))
            ],
          );
        });
  }

  Widget widgetWithHeader(String header, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(
          height: 4,
        ),
        content
      ],
    );
  }
}

class _FootnoteWidgetsFactory extends WidgetFactory {
  final smilieOp = BuildOp(onTree: (meta, tree) {
    tree.add<BuildBit>(WidgetBit.inline(tree, Tooltip(
      message: 'example',
      child: Icon(Icons.info))));
  },
  
  );

  @override
  void parse(BuildMetadata meta) {
    final e = meta.element;
    if (e.localName == 'footnote') {
      print(e.attributes['data-num'].replaceAll('\\', '').replaceAll('"', ''));
      meta.register(smilieOp);
      return;
    }

    return super.parse(meta);
  }
}
