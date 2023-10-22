import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:my_save_app/providers/project_provider.dart';
import 'package:my_save_app/services/dashboard_service.dart';
import 'package:provider/provider.dart';

import '../../../models/project.dart';
import '../../../theme/custom_theme_extension.dart';
import 'delete_project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({required this.project, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension? customTheme =
        Theme.of(context).extension<CustomThemeExtension>();

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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          project.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: LinearProgressIndicator(
                        value: savingsStatusInPercent,
                        backgroundColor: customTheme!.progressBarColor),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          '${(savingsStatusInPercent * 100).toStringAsFixed(0)}${AppLocalizations.of(context).percent}',
                          style: TextStyle(
                              color: customTheme.percentProgressColor)),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${AppLocalizations.of(context).createdAt} ${DateFormat('dd. MMM. y').format(project.createdAt)}',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey[500],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
