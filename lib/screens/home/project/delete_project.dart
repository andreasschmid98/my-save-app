import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/screens/shared/constants.dart';

import '../../../models/project.dart';
import '../../../providers/project_provider.dart';

class DeleteProject extends StatelessWidget {
  const DeleteProject({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text('${project.title} ${Constants.DELETE}'),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                      onPressed: () async {
                        await context
                            .read<ProjectProvider>()
                            .deleteProjectById(project.id)
                            .then((response) => Navigator.pop(context));
                      },
                      child: const Text(Constants.YES)),
                  FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(Constants.NO))
                ],
              )
            ],
          ),
        ));
  }
}
