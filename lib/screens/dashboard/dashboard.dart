import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_save_app/providers/project_provider.dart';
import 'package:my_save_app/screens/home/project/edit_project.dart';

import 'entry/create_entry.dart';
import 'entry/entry_list.dart';
import 'overview/progress_overview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          centerTitle: true,
          title:
              Text(project!.title),
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
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: AppLocalizations.of(context).overview,
                icon: const Icon(Icons.stacked_bar_chart),
              ),
              Tab(
                text: AppLocalizations.of(context).entries,
                icon: const Icon(Icons.format_list_bulleted),
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
                  return const CreateEntry();
                });
          },
          label: Text(AppLocalizations.of(context).newEntry),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
