import '../models/project.dart';

abstract class ProjectRepository {
  Future<Project> getProjectById(int id);

  Future<List<Project>> getAllProjects();

  Future<Project> createProject(String title, double savingsGoal);

  Future<int> deleteProjectById(int id);
}
