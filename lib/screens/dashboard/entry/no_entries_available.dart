import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/entry.dart';
import 'enums/filter.dart';

class NoEntriesAvailable extends StatelessWidget {
  final List<Entry> recurrentEntries;
  final List<Entry> singleEntries;
  final Filter filter;

  const NoEntriesAvailable(
      {required this.recurrentEntries,
      required this.singleEntries,
      required this.filter,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_showNoEntriesAvailable()) {
      return Center(
          child: Text(AppLocalizations.of(context).noEntriesAvailable));
    }
    return Container();
  }

  bool _showNoEntriesAvailable() {
    return (filter == Filter.All &&
            singleEntries.isEmpty &&
            recurrentEntries.isEmpty) ||
        (filter == Filter.Single && singleEntries.isEmpty) ||
        (filter == Filter.Recurrent && recurrentEntries.isEmpty);
  }
}
