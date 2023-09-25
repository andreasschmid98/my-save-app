import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/project.dart';
import '../../../providers/project_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteProject extends StatelessWidget {
  const DeleteProject({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(AppLocalizations.of(context).deleteProject),
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                AppLocalizations.of(context).projectDeleted)));
                      },
                      child: Text(AppLocalizations.of(context).yes)),
                  FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context).no))
                ],
              )
            ],
          ),
        ));
  }
}
