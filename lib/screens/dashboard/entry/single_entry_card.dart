import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:my_save_app/screens/dashboard/entry/delete_single_entry.dart';
import 'package:provider/provider.dart';

import '../../../models/entry.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/project_provider.dart';

class SingleEntryCard extends StatelessWidget {
  final Entry entry;

  const SingleEntryCard({required this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final project = context.watch<ProjectProvider>().currentProject;
    final locale = context.watch<LocaleProvider>().locale;

    return InkWell(
        onLongPress: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return DeleteSingleEntry(entry: entry);
              });
        },
        child: Card(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: ListTile(
                  title: Text(
                    entry.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${entry.saved.toStringAsFixed(2)} ${project!.currency}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          '${AppLocalizations.of(context).createdAt} ${DateFormat('dd. MMM. y', locale!.languageCode).format(entry.createdAt)}',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
