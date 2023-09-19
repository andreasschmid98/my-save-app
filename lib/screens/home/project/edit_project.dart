import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/providers/project_provider.dart';

import 'package:savings_tracker_app/screens/shared/constants.dart';

import '../../../models/project.dart';

class EditProject extends StatefulWidget {
  final Project project;

  const EditProject({super.key, required this.project});

  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  final _formKey = GlobalKey<FormState>();

  String? title;
  double? savingsGoal;

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
                    initialValue: widget.project.title,
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
                    initialValue: widget.project.savingsGoal.toStringAsFixed(2),
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
                        title = title ?? widget.project.title;
                        savingsGoal = savingsGoal ?? widget.project.savingsGoal;
                        Project project = Project(
                            id: widget.project.id,
                            title: title!,
                            savingsGoal: savingsGoal!);

                        if (_formKey.currentState!.validate()) {
                          await context
                              .read<ProjectProvider>()
                              .updateProject(project)
                              .then((response) => Navigator.pop(context));
                        }
                      },
                      child: const Text(Constants.SAVE_CHANGES))
                ]),
              ))),
    );
  }

  bool _savingsGoalInputIsValid(String savingsGoalInput) {
    return savingsGoalInput.isNotEmpty &&
        double.tryParse(savingsGoalInput.replaceAll(',', '.')) != null;
  }
}
