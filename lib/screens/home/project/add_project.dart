import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/providers/project_provider.dart';

import 'package:savings_tracker_app/screens/shared/constants.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  double savingsGoal = 0.0;

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
                        hintText: Constants.TITEL,
                        prefixIcon: const Icon(Icons.description_outlined)),
                    validator: (titleInput) =>
                        titleInput!.isEmpty ? Constants.TITLE_REMINDER : null,
                    onChanged: (titleInput) {
                      setState(() => title = titleInput);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: Constants.textInputDecoration.copyWith(
                        hintText: Constants.SAVINGS_GOAL,
                        prefixIcon: const Icon(Icons.euro_rounded)),
                    validator: (savingsGoalInput) =>
                        _savingsGoalInputIsValid(savingsGoalInput!)
                            ? null
                            : Constants.SAVINGS_GOAL_REMINDER,
                    onChanged: (savingsGoalInput) {
                      setState(() => savingsGoal =
                          double.parse(savingsGoalInput.replaceAll(',', '.')));
                    },
                  ),
                  const SizedBox(height: 20.0),
                  FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await context
                              .read<ProjectProvider>()
                              .createProject(title, savingsGoal)
                              .then((response) => Navigator.pop(context));
                        }
                      },
                      child: const Text(Constants.CREATE_PROJECT))
                ]),
              ))),
    );
  }

  bool _savingsGoalInputIsValid(String savingsGoalInput) {
    return savingsGoalInput.isNotEmpty &&
        double.tryParse(savingsGoalInput.replaceAll(',', '.')) != null;
  }
}
