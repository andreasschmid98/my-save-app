import 'package:flutter/material.dart';
import 'package:savings_tracker_app/screens/home/project_list.dart';


class Home extends StatelessWidget {
  Home({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
            child: Text('Alle Sparprojekte')),
      ),
      body: Container(
          margin: const EdgeInsets.all(30.0), child: const ProjectList()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: implement add project
        },
        label: Text('Neue Gruppe'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
