import 'package:flutter/material.dart';
import 'package:savings_tracker_app/models/project.dart';
import 'package:savings_tracker_app/repositories/project_repository.dart';
import 'package:savings_tracker_app/services/database_service.dart';

class ProjectProvider with ChangeNotifier {

  final ProjectRepository _projectRepository = DatabaseService.instance;
  bool initialized = false;
  Project? currentProject;
  List<Project> projects = [];

  Future<void> createProject(String title, double savingsGoal) async {
    await _projectRepository.createProject(title, savingsGoal);
    projects = await _projectRepository.getAllProjects();
    notifyListeners();
  }

  Future<void> deleteProjectById(int id) async {
    await _projectRepository.deleteProjectById(id);
    projects.removeWhere((project) => project.id == id);
    notifyListeners();
  }

  void initialize () async {
    projects = await _projectRepository.getAllProjects();
    initialized = true;
    notifyListeners();
  }

}