import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_save_app/screens/dashboard/entry/enums/entry_action.dart';
import 'package:my_save_app/services/dashboard_service.dart';
import 'package:provider/provider.dart';

import '../../../models/entry.dart';
import '../../../models/frequency.dart';
import '../../../providers/project_provider.dart';

class ActionRecurrentEntry extends StatefulWidget {
  const ActionRecurrentEntry({
    super.key,
    required this.entry,
  });

  final Entry entry;

  @override
  State<ActionRecurrentEntry> createState() => _ActionRecurrentEntryState();
}

class _ActionRecurrentEntryState extends State<ActionRecurrentEntry> {
  var _action = EntryAction.SaveAsSingle;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(AppLocalizations.of(context).recurrentEntryActionQuestion),
            const SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context).stopRecurrentEntry),
                      Text(
                        AppLocalizations.of(context)
                            .stopRecurrentEntryInformation,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  leading: Radio<EntryAction>(
                    value: EntryAction.SaveAsSingle,
                    groupValue: _action,
                    onChanged: (EntryAction? selectedAction) {
                      setState(() {
                        _action = selectedAction!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context).deleteRecurrentEntry),
                      Text(
                        AppLocalizations.of(context)
                            .deleteRecurrentEntryInformation,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  leading: Radio<EntryAction>(
                    value: EntryAction.Delete,
                    groupValue: _action,
                    onChanged: (EntryAction? selectedAction) {
                      setState(() {
                        _action = selectedAction!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),
                FilledButton(
                    onPressed: () async {
                      if (_action == EntryAction.Delete) {
                        await context
                            .read<ProjectProvider>()
                            .deleteEntryById(widget.entry.id)
                            .then((response) => Navigator.pop(context));

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                AppLocalizations.of(context).entryDeleted)));
                      } else {
                        final totalSavings = DashboardService()
                            .calculateTotalSavingsOfRecurrentEntry(
                                widget.entry);
                        await context
                            .read<ProjectProvider>()
                            .createEntry(
                                widget.entry.description,
                                widget.entry.projectId,
                                totalSavings,
                                Frequency.SINGLE,
                                widget.entry.createdAt)
                            .then((response) => context
                                .read<ProjectProvider>()
                                .deleteEntryById(widget.entry.id)
                                .then((response) => Navigator.pop(context)));
                      }
                    },
                    child: Text(AppLocalizations.of(context)
                        .executeRecurrentEntryAction))
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
