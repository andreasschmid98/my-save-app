import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/providers/project_provider.dart';
import 'package:savings_tracker_app/screens/dashboard/overview/percent_progress_card.dart';
import 'package:savings_tracker_app/screens/dashboard/overview/savings_information_card.dart';
import '../../../models/project.dart';
import '../../../services/calculator_service.dart';

class ProgressOverview extends StatelessWidget {

  ProgressOverview({super.key});

  @override
  Widget build(BuildContext context) {

    final project = context.watch<ProjectProvider>().currentProject;

    return Container(
      height: 700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: PercentProgressCard(savingStatusInPercent: 10000),
          ),
          SizedBox(height: 15),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Flexible(
                    child: SavingsInformationCard(
                        infoNumber: 10000, infoText: 'gespart')),
                SizedBox(width: 15),
                Flexible(
                    child: SavingsInformationCard(
                        infoNumber: 10000, infoText: 'offen')),
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
