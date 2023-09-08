import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/screens/dashboard/entry/delete_entry.dart';

import '../../../models/entry.dart';

class EntryCard extends StatelessWidget {
  Entry entry;

  EntryCard({required this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return DeleteEntry(entry: entry);
              });
        },
        child: Card(
            child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text(entry.description),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text('${entry.saved.toStringAsFixed(2)} Euro'),
            ),
          ],
        )));
  }
}
