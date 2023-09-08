import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/providers/project_provider.dart';
import 'package:savings_tracker_app/screens/dashboard/overview/percent_progress_card.dart';
import 'package:savings_tracker_app/screens/dashboard/overview/savings_information_card.dart';
import '../../../services/dashboard_service.dart';
import '../../shared/loading.dart';

class ProgressOverview extends StatelessWidget {
  ProgressOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final project = context.watch<ProjectProvider>().currentProject;
    final entries = context.watch<ProjectProvider>().projects[project];
    final totalSavings = DashboardService().calculateTotalSavings(entries!);
    final savingsStatusInPercent = DashboardService()
        .calculateSavingsStatusInPercent(entries, project!.savingsGoal);
    final remainingAmount = DashboardService()
        .calculateRemainingAmount(entries, project!.savingsGoal);

    return Container(
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
          SizedBox(height: 15),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Flexible(
                    child: SavingsInformationCard(
                        infoNumber: totalSavings, infoText: 'gespart')),
                SizedBox(width: 15),
                Flexible(
                    child: SavingsInformationCard(
                        infoNumber: remainingAmount, infoText: 'offen')),
                SizedBox(width: 15),
                Flexible(
                    child: SavingsInformationCard(
                        infoNumber: project!.savingsGoal, infoText: 'Ziel')),
              ],
            ),
          ),
          SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
