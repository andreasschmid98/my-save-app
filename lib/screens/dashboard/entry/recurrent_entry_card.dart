import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:my_save_app/factories/frequency_factory.dart';
import 'package:my_save_app/screens/dashboard/entry/action_recurrent_entry.dart';
import 'package:provider/provider.dart';

import '../../../models/entry.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/project_provider.dart';
import '../../../services/dashboard_service.dart';

class RecurrentEntryCard extends StatelessWidget {
  final Entry entry;

  const RecurrentEntryCard({required this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final project = context.watch<ProjectProvider>().currentProject;
    final locale = context.watch<LocaleProvider>().locale;

    return InkWell(
        onLongPress: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return ActionRecurrentEntry(entry: entry);
              });
        },
        child: Card(
          child: ExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  '${DashboardService().calculateTotalSavingsOfRecurrentEntry(entry).toStringAsFixed(2)} ${project!.currency}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
            leading: const Icon(Icons.cached),
            shape: const Border(),
            expandedAlignment: Alignment.centerLeft,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${AppLocalizations.of(context).startingDate}: ${DateFormat.yMd(locale!.languageCode).format(entry.startingDate)}',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey[500],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${entry.saved.toStringAsFixed(2)} ${project.currency} / ${FrequencyFactory.createFrequencyString(entry.frequency, context)}',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
