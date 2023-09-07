import 'package:path/path.dart';
import 'package:savings_tracker_app/models/project.dart';
import 'package:savings_tracker_app/repositories/entry_repository.dart';
import 'package:savings_tracker_app/repositories/project_repository.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService implements ProjectRepository, EntryRepository {

  static int nextId = 1;
  static const String _PROJECTS_TABLE = 'projects';

  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();


  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'savings_tracker.db'),
      onCreate: (db, version) {
        return db.execute('''
  CREATE TABLE projects(
  id INTEGER PRIMARY KEY NOT NULL,
  title TEXT,
  savingsGoal REAL
  );
  CREATE TABLE entries(
    id INTEGER PRIMARY KEY NOT NULL,
    description TEXT,
    saved REAL,
    projectId TEXT
    );
  ''');
      },
      version: 1,
    );
  }

  @override
  Future<Project> createProject(String title, double savingsGoal) async {
    Project project = Project(
        id: nextId++, title: title, savingsGoal: savingsGoal);
    final Database db = await _getDatabase();
    final id = await db.insert(DatabaseService._PROJECTS_TABLE, project.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return getProjectById(id);
  }

  @override
  Future<List<Project>> getAllProjects() async {
    final Database db = await _getDatabase();
    final projectsAsMap = await db.query(DatabaseService._PROJECTS_TABLE);

    return projectsAsMap.map((projectAsMap) {
      return Project.fromMap(projectAsMap);
    }).toList();
  }

  @override
  Future<Project> getProjectById(int id) async {
    final Database db = await _getDatabase();

    final projectAsMap =
    await db.query(DatabaseService._PROJECTS_TABLE, where: 'id = ?',
        whereArgs: [id],
        limit: 1);

    return Project.fromMap(projectAsMap.first);
  }

  @override
  Future<int> deleteProjectById(int id) async {
    final Database db = await _getDatabase();
    return await db.delete(DatabaseService
        ._PROJECTS_TABLE, where: 'id = ?', whereArgs: [id]);
    }
}
