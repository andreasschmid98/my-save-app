import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_save_app/screens/dashboard/entry/single_entry_card.dart';

import '../../../models/entry.dart';
import '../../../models/filter.dart';

class SingleEntryList extends StatelessWidget {
  final List<Entry> singleEntries;
  final List<Entry> recurrentEntries;
  final Filter filter;

  const SingleEntryList(
      {required this.singleEntries,
      required this.recurrentEntries,
      required this.filter,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (filter == Filter.Recurrent) {
      return Container();
    } else if (filter == Filter.All ||
        (filter == Filter.Single && singleEntries.isNotEmpty)) {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: singleEntries.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final entry = singleEntries[index];
            return SingleEntryCard(entry: entry);
          });
    } else {
      return Center(
          child: Text(AppLocalizations.of(context).noEntriesAvailable));
    }
  }
}
