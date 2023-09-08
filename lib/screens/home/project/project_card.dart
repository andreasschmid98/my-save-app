import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/providers/project_provider.dart';
import 'package:savings_tracker_app/services/calculator_service.dart';
import '../../../models/project.dart';
import '../../../providers/entry_provider.dart';

class ProjectCard extends StatelessWidget {

  Project project;
  ProjectCard({required this.project, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  final entries = context.watch<ProjectProvider>().projects[project];
  final savingsStatusInPercent = CalculatorService().calculateSavingsStatusInPercent(entries!, project.savingsGoal);

    return InkWell(
      onTap: () {
        context.read<ProjectProvider>().currentProject = project;
        context.read<EntryProvider>().setCurrentEntries(project.id);

        Navigator.pushNamed(context, '/dashboard');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: ListTile(
                  title: Text(
                    project.title,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: LinearProgressIndicator(
                  value: savingsStatusInPercent,
                  backgroundColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
