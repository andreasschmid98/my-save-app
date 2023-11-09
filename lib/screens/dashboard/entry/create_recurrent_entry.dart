import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:my_save_app/models/frequency.dart';
import 'package:provider/provider.dart';

import '../../../providers/locale_provider.dart';
import '../../../providers/project_provider.dart';

class CreateRecurrentEntry extends StatefulWidget {
  const CreateRecurrentEntry({super.key});

  @override
  State<CreateRecurrentEntry> createState() => _CreateRecurrentEntryState();
}

class _CreateRecurrentEntryState extends State<CreateRecurrentEntry> {
  final _formKey = GlobalKey<FormState>();

  String description = '';
  double saved = 0.0;
  Frequency? frequency;
  DateTime? startingDate;
  bool startingDateSelected = false;

  bool _ignoreInput = false;

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>().locale;
    return IgnorePointer(
      ignoring: _ignoreInput,
      child: Wrap(children: [
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
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<Frequency>(
                            hint: Text(AppLocalizations.of(context).repeat),
                            onChanged: (Frequency? selectedFrequency) {
                              setState(() {
                                frequency = selectedFrequency!;
                              });
                            },
                            validator: (selectedFrequency) =>
                                selectedFrequency != null
                                    ? null
                                    : AppLocalizations.of(context)
                                        .frequencyReminder,
                            items: [
                              DropdownMenuItem<Frequency>(
                                value: Frequency.DAILY,
                                child: Text(AppLocalizations.of(context).daily),
                              ),
                              DropdownMenuItem<Frequency>(
                                value: Frequency.WEEKLY,
                                child:
                                    Text(AppLocalizations.of(context).weekly),
                              ),
                              DropdownMenuItem<Frequency>(
                                value: Frequency.MONTHLY,
                                child:
                                    Text(AppLocalizations.of(context).monthly),
                              ),
                              DropdownMenuItem<Frequency>(
                                value: Frequency.YEARLY,
                                child:
                                    Text(AppLocalizations.of(context).yearly),
                              ),
                            ],
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              prefixIcon: Icon(Icons.cached),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: startingDate != null
                              ? DateFormat.yMd(locale!.languageCode)
                                  .format(startingDate!)
                              : AppLocalizations.of(context).startingDate,
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: AppLocalizations.of(context).startingDate,
                          prefixIcon: const Icon(Icons.date_range)),
                      validator: (selectedDate) => startingDateSelected
                          ? null
                          : AppLocalizations.of(context).startingDateReminder,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());

                        startingDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2100),
                        );
                        startingDateSelected =
                            startingDate == null ? false : true;
                      },
                    ),
                    const SizedBox(height: 15.0),
                    FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _ignoreInput = true;
                            int projectId = context
                                .read<ProjectProvider>()
                                .currentProject!
                                .id;
                            await context
                                .read<ProjectProvider>()
                                .createEntry(description, projectId, saved,
                                    frequency!, startingDate!)
                                .then((response) => _onSuccess(context))
                                .onError(
                                    (error, stackTrace) => _onError(context));
                          }
                        },
                        child: Text(AppLocalizations.of(context).createEntry))
                  ]),
                )))
      ]),
    );
  }

  bool _amountInputIsValid(String amountInput) {
    return amountInput.isNotEmpty &&
        double.tryParse(amountInput.replaceAll(',', '.')) != null;
  }

  void _onError(BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).error)));
  }

  void _onSuccess(BuildContext context) {
    Navigator.pop(context);
  }
}
