import 'package:flutter/material.dart';
import '../../models/project.dart';

//TODO: Make Group Card prettier
class ProjectCard extends StatelessWidget {

  Project group;
  ProjectCard({required this.group, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/dashboard');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0), // Horizontalen Abstand anpassen
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: ListTile(
                  title: Text(
                    group.title,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: LinearProgressIndicator(
                  value: 0.5, // Ändere den Fortschrittswert nach Bedarf (0.0 bis 1.0)
                  backgroundColor: Colors.grey, // Ändere die Hintergrundfarbe nach Bedarf
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
