import 'package:flutter/material.dart';

import '../../../models/entry.dart';

class EntryCard extends StatelessWidget {

  Entry entry;

  EntryCard({required this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child:
              Row(
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
              )
      );
  }
}
