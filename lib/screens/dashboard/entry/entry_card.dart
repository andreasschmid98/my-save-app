import 'package:flutter/material.dart';
import 'package:savings_tracker_app/screens/dashboard/entry/delete_entry.dart';

import '../../../models/entry.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;

  const EntryCard({required this.entry, Key? key}) : super(key: key);

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
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: ListTile(
                  title: Text(
                    entry.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${entry.saved.toStringAsFixed(2)} €',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
