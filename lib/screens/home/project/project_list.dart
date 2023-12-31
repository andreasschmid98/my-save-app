import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/project_provider.dart';
import 'project_card.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({super.key});

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    final projects = context.watch<ProjectProvider>().projects.keys.toList();

    return projects.isEmpty
        ? Center(child: Text(AppLocalizations.of(context).noProjectsAvailable))
        : ListView.builder(
            itemCount: projects.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final project = projects[index];
              return ProjectCard(project: project);
            });
  }
}
