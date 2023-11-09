import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../models/entry.dart';
import '../../../providers/project_provider.dart';

class DeleteSingleEntry extends StatelessWidget {
  DeleteSingleEntry({
    super.key,
    required this.entry,
  });

  final Entry entry;
  bool _ignoreInput = false;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: _ignoreInput,
      child: Wrap(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(AppLocalizations.of(context).deleteEntry),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                      onPressed: () async {
                        _ignoreInput = true;
                        await context
                            .read<ProjectProvider>()
                            .deleteEntryById(entry.id)
                            .then((response) => _onSuccess(context))
                            .onError((error, stackTrace) => _onError(context));
                      },
                      child: Text(AppLocalizations.of(context).yes)),
                  FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context).no))
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  void _onError(BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).error)));
  }

  void _onSuccess(BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).entryDeleted)));
  }
}
