import 'package:path/path.dart';
import 'package:savings_tracker_app/models/entry.dart';
import 'package:savings_tracker_app/models/project.dart';
import 'package:savings_tracker_app/repositories/entry_repository.dart';
import 'package:savings_tracker_app/repositories/project_repository.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService implements ProjectRepository, EntryRepository {
  static int nextProjectId = 1;
  static int nextEntryId = 1;
  static const String _PROJECTS_TABLE = 'projects';
  static const String _ENTRIES_TABLE = 'entries';

  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  Future<Database> _getDatabase() async {
    databaseFactory.deleteDatabase(await getDatabasesPath());
    return openDatabase(
      join(await getDatabasesPath(), 'savings_tracker.db'),
      onCreate: (db, version) {
        return _createTables(db);
      },
      version: 1,
    );
  }

  void _createTables(Database db) {
    db.execute('''
  CREATE TABLE projects(
  id INTEGER PRIMARY KEY NOT NULL,
  title TEXT,
  savingsGoal REAL
  )
  ''');
    db.execute('''
  CREATE TABLE entries(
  id INTEGER PRIMARY KEY NOT NULL,
  description TEXT,
  saved REAL,
  projectId INTEGER
  )
  ''');
  }

  @override
  Future<Project> createProject(String title, double savingsGoal) async {
    Project project =
        Project(id: nextProjectId++, title: title, savingsGoal: savingsGoal);
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

    final projectAsMap = await db.query(DatabaseService._PROJECTS_TABLE,
        where: 'id = ?', whereArgs: [id], limit: 1);

    return Project.fromMap(projectAsMap.first);
  }

  @override
  Future<int> deleteProjectById(int id) async {
    final Database db = await _getDatabase();
    return await db.delete(DatabaseService._PROJECTS_TABLE,
        where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<Entry> createEntry(String description, int projectId, double saved) async {
    Entry entry =
    Entry(id: nextEntryId++, projectId: projectId, description: description, saved: saved);
    final Database db = await _getDatabase();
    final id = await db.insert(DatabaseService._ENTRIES_TABLE, entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return getEntryById(id);
  }

  @override
  Future<Entry> getEntryById(int id) async {
    final Database db = await _getDatabase();

    final entryAsMap = await db.query(DatabaseService._ENTRIES_TABLE,
        where: 'id = ?', whereArgs: [id], limit: 1);

    return Entry.fromMap(entryAsMap.first);
  }

  @override
  Future<int> deleteEntryById(int id) {
    // TODO: implement deleteEntryById
    throw UnimplementedError();
  }

  @override
  Future<List<Entry>> getEntriesByProjectId(int projectId) async {
    final Database db = await _getDatabase();

    final entriesAsMap = await db.query(DatabaseService._ENTRIES_TABLE,
        where: 'projectId = ?', whereArgs: [projectId]);
    return entriesAsMap.map((entryAsMap) {
      return Entry.fromMap(entryAsMap);
    }).toList();
  }
}