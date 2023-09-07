import 'package:flutter/material.dart';
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
    final projects = context.watch<ProjectProvider>().projects;

    return projects.isEmpty
        ? Text('Keine Projekte')
        : ListView.builder(
            itemCount: projects.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final project = projects[index];
              return Dismissible(
                  key: Key(project.id.toString()),
                  background: Container(
                    child: Icon(Icons.delete_forever),
                  ),
                  child: ProjectCard(project: project),
                  onDismissed: (direction) {
                    context.read<ProjectProvider>().deleteProjectById(project.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Projekt gelöscht')));
                  });
            });
  }
}
