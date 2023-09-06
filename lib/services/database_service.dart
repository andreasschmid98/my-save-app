import 'package:path/path.dart';
import 'package:savings_tracker_app/models/project.dart';
import 'package:savings_tracker_app/repositories/entry_repository.dart';
import 'package:savings_tracker_app/repositories/project_repository.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService implements ProjectRepository, EntryRepository {

  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();


  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'savings_tracker.db'),
      onCreate: (db, version) {
        return db.execute('''
  CREATE TABLE projects(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  title TEXT,
  savingsGoal REAL
  );
  CREATE TABLE entries(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    description TEXT,
    saved REAL,
    projectId INTEGER
    );
  ''');
      },
      version: 1,
    );
  }

  @override
  Future<Project> createProject(Project project) async {
    final Database db = await _getDatabase();
    final id = await db.insert('projects', project.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return getProjectById(id);
  }

  @override
  Future<List<Project>> getAllProjects() async {
    final Database db = await _getDatabase();
    final projectsAsMap = await db.query('projects');

    return projectsAsMap.map((projectAsMap) {
      return Project.fromMap(projectAsMap);
    }).toList();
  }

  @override
  Future<Project> getProjectById(int id) async {
    final Database db = await _getDatabase();

    final projectAsMap =
        await db.query('projects', where: 'id = ?', whereArgs: [id], limit: 1);

    return Project.fromMap(projectAsMap as Map<String, dynamic>);
  }
}
