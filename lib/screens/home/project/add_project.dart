import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/providers/project_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../models/project.dart';
import '../../shared/constants.dart';

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
                padding: EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Titel',
                        prefixIcon: Icon(Icons.description_outlined)),
                    validator: (val) =>
                    val!.isEmpty
                        ? 'Welchen Titel soll Dein Projekt haben?'
                        : null,
                    onChanged: (val) {
                      setState(() => title = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Sparziel',
                        prefixIcon: Icon(Icons.euro_rounded)),
                    validator: (val) =>
                    val!.isEmpty ? 'Was ist dein Sparziel?' : null,
                    onChanged: (val) {
                      setState(() => savingsGoal = double.parse(val));
                    },
                  ),
                  const SizedBox(height: 20.0),
                  FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await context
                              .read<ProjectProvider>()
                              .createProject(title, savingsGoal).then((response) =>
                              Navigator.pop(context));
                        }
                      },
                      child: const Text('Projekt erstellen'))
                ]),
              ))),
    );
  }
}
