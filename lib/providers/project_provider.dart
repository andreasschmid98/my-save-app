import 'package:flutter/material.dart';
import 'package:my_save_app/models/project.dart';
import 'package:my_save_app/repositories/project_repository.dart';
import 'package:my_save_app/services/database_service.dart';

import '../models/entry.dart';
import '../repositories/entry_repository.dart';

class ProjectProvider with ChangeNotifier {
  final ProjectRepository _projectRepository = DatabaseService.instance;
  final EntryRepository _entryRepository = DatabaseService.instance;

  bool initialized = false;

  Project? currentProject;
  Map<Project, List<Entry>> projects = {};

  void initialize() async {
    projects = await _getRefreshedProjects();
    initialized = true;
    notifyListeners();
  }

  Future<void> createProject(
      String title, double savingsGoal, String currency) async {
    await _projectRepository.createProject(title, savingsGoal, currency);
    projects = await _getRefreshedProjects();
    notifyListeners();
  }

  Future<void> deleteProjectById(int id) async {
    await _projectRepository.deleteProjectById(id);
    projects = await _getRefreshedProjects();
    notifyListeners();
  }

  Future<void> updateProject(Project project) async {
    await _projectRepository.updateProject(project);
    currentProject = project;
    projects = await _getRefreshedProjects();
    notifyListeners();
  }

  Future<void> createEntry(
      String description, int projectId, double saved) async {
    await _entryRepository.createEntry(description, projectId, saved);
    projects = await _getRefreshedProjects();
    notifyListeners();
  }

  Future<void> deleteEntryById(int id) async {
    await _entryRepository.deleteEntryById(id);
    projects = await _getRefreshedProjects();
    notifyListeners();
  }

  Future<Map<Project, List<Entry>>> _getRefreshedProjects() async {
    Map<Project, List<Entry>> projectsMap = {};
    final allProjects = await _projectRepository.getAllProjects();

    for (var project in allProjects) {
      final entries = await _entryRepository.getEntriesByProjectId(project.id);
      projectsMap[project] = entries;
    }
    return projectsMap;
  }
}
