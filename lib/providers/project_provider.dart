import 'package:flutter/material.dart';
import 'package:savings_tracker_app/models/project.dart';
import 'package:savings_tracker_app/repositories/project_repository.dart';
import 'package:savings_tracker_app/services/database_service.dart';

class ProjectProvider with ChangeNotifier {

  final ProjectRepository _projectRepository = DatabaseService.instance;
  bool initialized = false;
  Project? currentProject;
  List<Project> projects = [];

  Future<void> createProject(Project project) async {
    await _projectRepository.createProject(project);
    projects = await _projectRepository.getAllProjects();
    notifyListeners();
  }

  void initialize () async {
    projects = await _projectRepository.getAllProjects();
    initialized = true;
    notifyListeners();
  }

}