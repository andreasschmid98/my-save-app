import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_save_app/models/frequency.dart';
import 'package:provider/provider.dart';

import '../../../providers/project_provider.dart';

class CreateSingleEntry extends StatefulWidget {
  const CreateSingleEntry({super.key});

  @override
  State<CreateSingleEntry> createState() => _CreateSingleEntryState();
}

class _CreateSingleEntryState extends State<CreateSingleEntry> {
  final _formKey = GlobalKey<FormState>();

  String description = '';
  double saved = 0.0;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Center(
          child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text(AppLocalizations.of(context).createEntry),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: AppLocalizations.of(context).description,
                        prefixIcon: const Icon(Icons.description_outlined)),
                    validator: (descriptionInput) => descriptionInput!.isEmpty
                        ? AppLocalizations.of(context).descriptionReminder
                        : null,
                    onChanged: (descriptionInput) {
                      setState(() => description = descriptionInput);
                    },
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: AppLocalizations.of(context).amount,
                        prefixIcon: const Icon(Icons.money)),
                    validator: (amountInput) =>
                        _amountInputIsValid(amountInput!)
                            ? null
                            : AppLocalizations.of(context).amountReminder,
                    onChanged: (amountInput) {
                      setState(() => saved =
                          double.parse(amountInput.replaceAll(',', '.')));
                    },
                  ),
                  const SizedBox(height: 15.0),
                  FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          int projectId = context
                              .read<ProjectProvider>()
                              .currentProject!
                              .id;
                          await context
                              .read<ProjectProvider>()
                              .createEntry(description, projectId, saved,
                                  Frequency.SINGLE, DateTime.now())
                              .then((response) => Navigator.pop(context));
                        }
                      },
                      child: Text(AppLocalizations.of(context).createEntry))
                ]),
              )))
    ]);
  }

  bool _amountInputIsValid(String amountInput) {
    return amountInput.isNotEmpty &&
        double.tryParse(amountInput.replaceAll(',', '.')) != null;
  }
}
