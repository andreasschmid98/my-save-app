import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/providers/project_provider.dart';
import 'package:savings_tracker_app/screens/shared/constants.dart';
import 'package:savings_tracker_app/services/dashboard_service.dart';
import '../../../models/project.dart';
import 'delete_project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({required this.project, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entries = context.watch<ProjectProvider>().projects[project];
    final savingsStatusInPercent = DashboardService()
        .calculateSavingsStatusInPercent(entries!, project.savingsGoal);

    return InkWell(
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return DeleteProject(project: project);
            });
      },
      onTap: () {
        context.read<ProjectProvider>().currentProject = project;
        context.read<ProjectProvider>().initialize();
        Navigator.pushNamed(context, '/dashboard');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    project.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: LinearProgressIndicator(
                  value: savingsStatusInPercent,
                  backgroundColor: Colors.grey,
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      '${(savingsStatusInPercent * 100).toStringAsFixed(0)}${Constants.PERCENT}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
