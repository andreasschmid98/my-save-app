import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/providers/project_provider.dart';
import 'package:savings_tracker_app/screens/dashboard/overview/percent_progress_card.dart';
import 'package:savings_tracker_app/screens/dashboard/overview/savings_information_card.dart';
import 'package:savings_tracker_app/screens/shared/constants.dart';
import '../../../services/dashboard_service.dart';

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
                        amount: totalSavings, description: Constants.SAVED)),
                const SizedBox(width: 15),
                Flexible(
                    child: SavingsInformationCard(
                        amount: remaining, description: Constants.OPEN)),
                const SizedBox(width: 15),
                Flexible(
                    child: SavingsInformationCard(
                        amount: project.savingsGoal,
                        description: Constants.GOAL)),
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
