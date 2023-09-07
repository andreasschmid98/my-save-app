import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/models/project.dart';
import 'package:savings_tracker_app/screens/shared/loading.dart';
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
    final projects = context.watch<ProjectProvider>().projects;

    return projects.isEmpty
        ? Text('Keine Projekte')
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