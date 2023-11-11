import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_save_app/models/currency.dart';
import 'package:my_save_app/providers/project_provider.dart';
import 'package:provider/provider.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({super.key});

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final _formKey = GlobalKey<FormState>();

  bool _ignoreInput = false;

  String title = '';
  double savingsGoal = 0.0;
  Currency? currency;

  @override
  Widget build(BuildContext context) {
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
                    Text(AppLocalizations.of(context).createProject),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: AppLocalizations.of(context).title,
                          prefixIcon: const Icon(Icons.description_outlined)),
                      validator: (titleInput) => titleInput!.isEmpty
                          ? AppLocalizations.of(context).titleReminder
                          : null,
                      onChanged: (titleInput) {
                        setState(() => title = titleInput);
                      },
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: AppLocalizations.of(context).savingsGoal,
                          prefixIcon: const Icon(Icons.check_circle_rounded)),
                      validator: (savingsGoalInput) =>
                          _savingsGoalInputIsValid(savingsGoalInput!)
                              ? null
                              : AppLocalizations.of(context)
                                  .savingsGoalReminder,
                      onChanged: (savingsGoalInput) {
                        setState(() => savingsGoal = double.parse(
                            savingsGoalInput.replaceAll(',', '.')));
                      },
                    ),
                    const SizedBox(height: 15.00),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<Currency>(
                            hint: Text(AppLocalizations.of(context).currency),
                            onChanged: (Currency? selectedCurrency) {
                              setState(() {
                                currency = selectedCurrency!;
                              });
                            },
                            validator: (selectedCurrency) => selectedCurrency !=
                                    null
                                ? null
                                : AppLocalizations.of(context).currencyReminder,
                            items: Currency.values
                                .map<DropdownMenuItem<Currency>>(
                                    (Currency currency) {
                              return DropdownMenuItem<Currency>(
                                value: currency,
                                child: Text(
                                    '${currency.symbol} (${currency.abbreviation})'),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              prefixIcon:
                                  Icon(Icons.currency_exchange_outlined),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _ignoreInput = true;
                            await context
                                .read<ProjectProvider>()
                                .createProject(
                                    title, savingsGoal, currency!.symbol)
                                .then((response) => _onSuccess(context))
                                .catchError(
                                    (error, stackTrace) => _onError(context));
                          }
                        },
                        child: Text(AppLocalizations.of(context).createProject))
                  ]),
                ))),
      ]),
    );
  }

  bool _savingsGoalInputIsValid(String savingsGoalInput) {
    return savingsGoalInput.isNotEmpty &&
        double.tryParse(savingsGoalInput.replaceAll(',', '.')) != null;
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
