import 'package:flutter/material.dart';
import 'project_card.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({super.key});

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    final projects = [];

    return projects.isEmpty
        ? Text('Keine Gruppen')
        : ListView.builder(
            itemCount: projects.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ProjectCard(group: projects[index]);
            });
  }
}
