import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/entry.dart';
import '../../../providers/project_provider.dart';

class DeleteEntry extends StatelessWidget {
  const DeleteEntry({
    super.key,
    required this.entry,
  });

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text('${entry.description} wirklich löschen?'),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                      onPressed: () async {
                        await context
                            .read<ProjectProvider>()
                            .deleteEntryById(entry.id)
                            .then((response) => Navigator.pop(context));
                      },
                      child: const Text('Ja')),
                  FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Nein'))
                ],
              )
            ],
          ),
        ));
  }
}
