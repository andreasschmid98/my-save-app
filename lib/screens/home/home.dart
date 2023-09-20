import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:savings_tracker_app/providers/project_provider.dart';
import 'package:savings_tracker_app/screens/home/project/create_project.dart';
import 'package:savings_tracker_app/screens/home/project/project_list.dart';

import 'package:savings_tracker_app/screens/shared/loading.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<ProjectProvider>().initialize();
    final initialized = context.watch<ProjectProvider>().initialized;

    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context).allProjects)),
      ),
      body: !initialized
          ? const Loading()
          : Container(
              margin: const EdgeInsets.all(30.0), child: const ProjectList()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const CreateProject();
              });
        },
        label: Text(AppLocalizations.of(context).createProject),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
