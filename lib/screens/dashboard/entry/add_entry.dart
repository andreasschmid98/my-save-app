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
                padding: EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Beschreibung',
                        prefixIcon: Icon(Icons.description_outlined)),
                    validator: (val) =>
                        val!.isEmpty ? 'Welche Beschreibung hat Dein Eintrag?' : null,
                    onChanged: (val) {
                      setState(() => description = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Betrag',
                        prefixIcon: Icon(Icons.euro_rounded)),
                    validator: (val) =>
                        val!.isEmpty ? 'Wie viel hast du gespart?' : null,
                    onChanged: (val) {
                      setState(() => saved = double.parse(val));
                    },
                  ),
                  const SizedBox(height: 20.0),
                  FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          int projectId = context.read<ProjectProvider>().currentProject!.id;
                          await context
                              .read<ProjectProvider>()
                              .createEntry(description, projectId, saved).then((response) =>
                              Navigator.pop(context));
                          }},
                      child: const Text('Eintrag erstellen'))
                ]),
              ))),
    );
  }
}
