import 'package:flutter/material.dart';

import 'entry_card.dart';


class EntryList extends StatefulWidget {
  const EntryList({super.key});

  @override
  State<EntryList> createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  @override
  Widget build(BuildContext context) {

    //TODO: replace with provider or something similar
    final entries = [];

    return entries.isEmpty
        ? Text('Keine Einträge')
        : ListView.builder(
            itemCount: entries.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final entryItem = entries[index];
              return Dismissible(
                  key: Key(entries[index].id),
                  background: Container(
                    child: Icon(Icons.delete_forever),
                  ),
                  child: EntryCard(entry: entryItem),
                  onDismissed: (direction) {
                    // TODO: Delete entry in db
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Eintrag entfernt')));
                  });
            });
  }
}
