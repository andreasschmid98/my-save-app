import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:my_save_app/screens/dashboard/entry/delete_entry.dart';

import '../../../models/entry.dart';
import '../../../providers/project_provider.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;

  const EntryCard({required this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final project = context.watch<ProjectProvider>().currentProject;

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
                flex: 2,
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
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${entry.saved.toStringAsFixed(2)} ${project!.currency}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          DateFormat('dd. MMM. y').format(entry.createdAt),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
