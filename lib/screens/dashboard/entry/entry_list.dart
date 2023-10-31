import 'package:flutter/material.dart';
import 'package:my_save_app/models/frequency.dart';
import 'package:my_save_app/screens/dashboard/entry/no_entries_available.dart';
import 'package:my_save_app/screens/dashboard/entry/recurrent_entry_list.dart';
import 'package:provider/provider.dart';

import '../../../providers/project_provider.dart';
import 'enums/filter.dart';
import 'single_entry_list.dart';

class EntryList extends StatefulWidget {
  const EntryList({super.key});

  @override
  State<EntryList> createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  Filter filter = Filter.All;

  @override
  Widget build(BuildContext context) {
    final project = context.watch<ProjectProvider>().currentProject;
    final entries = context.watch<ProjectProvider>().projects[project];
    final singleEntries =
        entries!.where((entry) => entry.frequency == Frequency.SINGLE).toList();
    final recurrentEntries =
        entries.where((entry) => entry.frequency != Frequency.SINGLE).toList();

    return Stack(children: [
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: SegmentedButton<Filter>(
                segments: const <ButtonSegment<Filter>>[
                  ButtonSegment<Filter>(
                      value: Filter.All, label: Icon(Icons.density_small)),
                  ButtonSegment<Filter>(
                      value: Filter.Recurrent, label: Icon(Icons.cached)),
                  ButtonSegment<Filter>(
                      value: Filter.Single,
                      label: Icon(Icons.arrow_forward_outlined)),
                ],
                selected: <Filter>{filter},
                onSelectionChanged: (Set<Filter> selectedFilter) {
                  setState(() {
                    filter = selectedFilter.first;
                  });
                },
                showSelectedIcon: false,
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity(horizontal: 4, vertical: -1),
                ),
              ),
            ),
            RecurrentEntryList(
                recurrentEntries: recurrentEntries,
                singleEntries: singleEntries,
                filter: filter),
            filter == Filter.All &&
                    recurrentEntries.isNotEmpty &&
                    singleEntries.isNotEmpty
                ? const Divider(height: 50)
                : Container(),
            SingleEntryList(
                singleEntries: singleEntries,
                recurrentEntries: recurrentEntries,
                filter: filter)
          ],
        ),
      ),
      NoEntriesAvailable(
          singleEntries: singleEntries,
          recurrentEntries: recurrentEntries,
          filter: filter)
    ]);
  }
}
