import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/project_provider.dart';
import 'entry_card.dart';

class EntryList extends StatefulWidget {
  const EntryList({super.key});

  @override
  State<EntryList> createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  @override
  Widget build(BuildContext context) {
    final project = context.watch<ProjectProvider>().currentProject;
    final entries = context.watch<ProjectProvider>().projects[project];

    return entries!.isEmpty
        ? Center(child: Text('Keine Einträge vorhanden.'))
        : ListView.builder(
            itemCount: entries.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return EntryCard(entry: entry);
            });
  }
}
