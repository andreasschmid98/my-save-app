import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_save_app/models/currency.dart';
import 'package:my_save_app/providers/project_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({super.key});

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  double savingsGoal = 0.0;
  Currency currency = Currency.EUR;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
          child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  const SizedBox(height: 20.0),
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
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: AppLocalizations.of(context).savingsGoal,
                        prefixIcon: const Icon(Icons.check_circle_rounded)),
                    validator: (savingsGoalInput) =>
                        _savingsGoalInputIsValid(savingsGoalInput!)
                            ? null
                            : AppLocalizations.of(context).savingsGoalReminder,
                    onChanged: (savingsGoalInput) {
                      setState(() => savingsGoal =
                          double.parse(savingsGoalInput.replaceAll(',', '.')));
                    },
                  ),
                  const SizedBox(height: 20.0),
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
                            prefixIcon: Icon(Icons.currency_exchange_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await context
                              .read<ProjectProvider>()
                              .createProject(
                                  title, savingsGoal, currency.symbol)
                              .then((response) => Navigator.pop(context));
                        }
                      },
                      child: Text(AppLocalizations.of(context).createProject))
                ]),
              ))),
    );
  }

  bool _savingsGoalInputIsValid(String savingsGoalInput) {
    return savingsGoalInput.isNotEmpty &&
        double.tryParse(savingsGoalInput.replaceAll(',', '.')) != null;
  }
}
