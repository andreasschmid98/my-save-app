import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/project_provider.dart';
import '../../shared/constants.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({super.key});

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  final _formKey = GlobalKey<FormState>();

  String description = '';
  double saved = 0.0;

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
                    decoration: Constants.textInputDecoration.copyWith(
                        hintText: Constants.DESCRIPTION,
                        prefixIcon: const Icon(Icons.description_outlined)),
                    validator: (descriptionInput) => descriptionInput!.isEmpty
                        ? Constants.DESCRIPTION_REMINDER
                        : null,
                    onChanged: (descriptionInput) {
                      setState(() => description = descriptionInput);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: Constants.textInputDecoration.copyWith(
                        hintText: Constants.AMOUNT,
                        prefixIcon: const Icon(Icons.euro_rounded)),
                    validator: (amountInput) =>
                        _amountInputIsValid(amountInput!)
                            ? null
                            : Constants.AMOUNT_REMINDER,
                    onChanged: (amountInput) {
                      setState(() => saved = double.parse(amountInput));
                    },
                  ),
                  const SizedBox(height: 20.0),
                  FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          int projectId = context
                              .read<ProjectProvider>()
                              .currentProject!
                              .id;
                          await context
                              .read<ProjectProvider>()
                              .createEntry(description, projectId, saved)
                              .then((response) => Navigator.pop(context));
                        }
                      },
                      child: const Text(Constants.CREATE_ENTRY))
                ]),
              ))),
    );
  }

  bool _amountInputIsValid(String amountInput) {
    return amountInput.isNotEmpty && double.tryParse(amountInput) != null;
  }
}
