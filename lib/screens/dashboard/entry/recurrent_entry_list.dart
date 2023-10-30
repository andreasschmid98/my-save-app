import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_save_app/models/entry.dart';

import '../../../models/filter.dart';
import 'recurrent_entry_card.dart';

class RecurrentEntryList extends StatelessWidget {
  final List<Entry> recurrentEntries;
  final List<Entry> singleEntries;
  final Filter filter;

  const RecurrentEntryList(
      {required this.recurrentEntries,
      required this.singleEntries,
      required this.filter,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (filter == Filter.Single) {
      return Container();
    } else if (filter == Filter.All ||
        (filter == Filter.Recurrent && recurrentEntries.isNotEmpty)) {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recurrentEntries!.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final entry = recurrentEntries[index];
            return RecurrentEntryCard(entry: entry);
          });
    } else {
      return Center(
          child: Text(AppLocalizations.of(context).noEntriesAvailable));
    }
  }
}
