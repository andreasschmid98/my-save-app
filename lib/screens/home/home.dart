import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/providers/project_provider.dart';
import 'package:savings_tracker_app/screens/home/project/add_project.dart';
import 'package:savings_tracker_app/screens/home/project/project_list.dart';
import 'package:savings_tracker_app/screens/shared/loading.dart';


class Home extends StatelessWidget {
  Home({super.key});
  @override
  Widget build(BuildContext context) {

    context.watch<ProjectProvider>().initialize();
    final initialized = context.watch<ProjectProvider>().initialized;
    final projects = context.watch<ProjectProvider>().projects;

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
            child: Text('Alle Sparprojekte')),
      ),
      body: !initialized ? Loading() :  Container(
          margin: const EdgeInsets.all(30.0), child: const ProjectList()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return AddProject();
              });
        },
        label: Text('Neues Projekt'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
