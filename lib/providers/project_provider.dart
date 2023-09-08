import 'package:flutter/material.dart';
import 'package:savings_tracker_app/models/project.dart';
import 'package:savings_tracker_app/repositories/project_repository.dart';
import 'package:savings_tracker_app/services/database_service.dart';

import '../models/entry.dart';
import '../repositories/entry_repository.dart';

class ProjectProvider with ChangeNotifier {

  final ProjectRepository _projectRepository = DatabaseService.instance;
  final EntryRepository _entryRepository = DatabaseService.instance;

  bool initialized = false;

  Project? currentProject;
  Map<Project, List<Entry>> projects = {};

  void initialize () async {
    await _refreshProjects();
    initialized = true;
    notifyListeners();
  }

  Future<void> createProject(String title, double savingsGoal) async {
    await _projectRepository.createProject(title, savingsGoal);
    await _refreshProjects();
    notifyListeners();
  }

  Future<void> deleteProjectById(int id) async {
    await _projectRepository.deleteProjectById(id);
    await _refreshProjects();
    notifyListeners();
  }

  Future<void> createEntry(String description, int projectId, double saved) async {
    await _entryRepository.createEntry(description, projectId, saved);
    await _refreshProjects();
    notifyListeners();
  }

  Future<void> deleteEntryById(int id) async {
    await _entryRepository.deleteEntryById(id);
    await _refreshProjects();
    notifyListeners();
  }

  _refreshProjects() async {
    List<Project> allProjects = await _projectRepository.getAllProjects();

    allProjects.forEach((project) async {
      projects[project] = await _entryRepository.getEntriesByProjectId(project.id);
    });
  }

}