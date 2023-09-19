import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/providers/project_provider.dart';
import 'package:savings_tracker_app/screens/home/project/edit_project.dart';
import 'package:savings_tracker_app/screens/shared/constants.dart';
import 'entry/add_entry.dart';
import 'entry/entry_list.dart';
import 'overview/progress_overview.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final project = context.watch<ProjectProvider>().currentProject;

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:
              Align(alignment: Alignment.center, child: Text(project!.title)),
          actions: [
            InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return EditProject(project: project);
                      });
                },
                child: const Icon(
                  Icons.edit,
                ))
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: Constants.OVERVIEW,
                icon: Icon(Icons.stacked_bar_chart),
              ),
              Tab(
                text: Constants.ENTIRES,
                icon: Icon(Icons.format_list_bulleted),
              ),
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(30.0),
          child: const TabBarView(
            children: <Widget>[
              Center(
                child: ProgressOverview(),
              ),
              EntryList()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const AddEntry();
                });
          },
          label: const Text(Constants.NEW_ENTRY),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
