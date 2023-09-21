import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_save_app/providers/project_provider.dart';
import 'package:my_save_app/screens/dashboard/overview/percent_progress_card.dart';
import 'package:my_save_app/screens/dashboard/overview/savings_information_card.dart';

import '../../../services/dashboard_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgressOverview extends StatelessWidget {
  const ProgressOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final project = context.watch<ProjectProvider>().currentProject;
    final entries = context.watch<ProjectProvider>().projects[project];
    final totalSavings = DashboardService().calculateTotalSavings(entries!);
    final savingsStatusInPercent = DashboardService()
        .calculateSavingsStatusInPercent(entries, project!.savingsGoal);
    final remaining = DashboardService()
        .calculateRemainingAmount(entries, project.savingsGoal);

    return SizedBox(
      height: 700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: PercentProgressCard(
                savingStatusInPercent: savingsStatusInPercent),
          ),
          const SizedBox(height: 15),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Flexible(
                    child: SavingsInformationCard(
                        amount: totalSavings,
                        description: AppLocalizations.of(context).saved)),
                const SizedBox(width: 15),
                Flexible(
                    child: SavingsInformationCard(
                        amount: remaining,
                        description: AppLocalizations.of(context).open)),
                const SizedBox(width: 15),
                Flexible(
                    child: SavingsInformationCard(
                        amount: project.savingsGoal,
                        description: AppLocalizations.of(context).goal)),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
