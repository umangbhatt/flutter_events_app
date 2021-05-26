import 'package:events_app/src/utils/routes.dart';
import 'package:events_app/src/viewModels/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<EventsViewModel>(context, listen: false).getEventsList();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(addNewEvent);
          },
        ),
        body: eventsList());
  }

  Widget eventsList() {
    return Consumer<EventsViewModel>(builder: (context, viewModel, child) {
      if (viewModel.eventsList == null)
        return Center(
          child: CircularProgressIndicator.adaptive(),
        );

      return ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: viewModel.eventsList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(eventDetails,
                    arguments: viewModel.eventsList[index]);
              },
              title: Text(viewModel.eventsList[index].eventName),
              subtitle: Text(viewModel.eventsList[index].eventLocation +
                  ' | ' +
                  viewModel.eventsList[index].dateString()),
            );
          });
    });
  }
}
