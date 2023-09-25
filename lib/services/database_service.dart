import 'dart:math';

import 'package:path/path.dart';
import 'package:my_save_app/models/entry.dart';
import 'package:my_save_app/models/project.dart';
import 'package:my_save_app/repositories/entry_repository.dart';
import 'package:my_save_app/repositories/project_repository.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService implements ProjectRepository, EntryRepository {
  final Set<int> _activeProjectIds = {};
  final Set<int> _activeEntryIds = {};

  static const String _PROJECTS_TABLE = 'projects';
  static const String _ENTRIES_TABLE = 'entries';
  static const int _MAX_ID = 100000;

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
  savingsGoal REAL,
  createdAt TEXT,
  currency TEXT
  )
  ''');
    db.execute('''
  CREATE TABLE entries(
  id INTEGER PRIMARY KEY NOT NULL,
  description TEXT,
  saved REAL,
  createdAt TEXT,
  projectId INTEGER
  )
  ''');
  }

  @override
  Future<Project> createProject(
      String title, double savingsGoal, String currency) async {
    Project project = Project(
        id: _createNextProjectId(),
        title: title,
        savingsGoal: savingsGoal,
        currency: currency);
    final Database db = await _getDatabase();
    final id = await db.insert(_PROJECTS_TABLE, project.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return getProjectById(id);
  }

  @override
  Future<List<Project>> getAllProjects() async {
    final Database db = await _getDatabase();
    final projectsAsMap = await db.query(_PROJECTS_TABLE);

    return projectsAsMap.map((projectAsMap) {
      return Project.fromMap(projectAsMap);
    }).toList();
  }

  @override
  Future<Project> getProjectById(int id) async {
    final Database db = await _getDatabase();

    final projectAsMap = await db.query(_PROJECTS_TABLE,
        where: 'id = ?', whereArgs: [id], limit: 1);

    return Project.fromMap(projectAsMap.first);
  }

  @override
  Future<int> deleteProjectById(int id) async {
    final Database db = await _getDatabase();
    await db.delete(_ENTRIES_TABLE, where: 'projectId = ?', whereArgs: [id]);
    return await db.delete(_PROJECTS_TABLE, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> updateProject(Project project) async {
    final Database db = await _getDatabase();
    return await db.update(_PROJECTS_TABLE, project.toMap(),
        where: 'id = ?', whereArgs: [project.id]);
  }

  @override
  Future<Entry> createEntry(
      String description, int projectId, double saved) async {
    Entry entry = Entry(
        id: _createNextEntryId(),
        projectId: projectId,
        description: description,
        saved: saved);
    final Database db = await _getDatabase();
    final id = await db.insert(_ENTRIES_TABLE, entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return getEntryById(id);
  }

  @override
  Future<Entry> getEntryById(int id) async {
    final Database db = await _getDatabase();

    final entryAsMap = await db.query(_ENTRIES_TABLE,
        where: 'id = ?', whereArgs: [id], limit: 1);

    return Entry.fromMap(entryAsMap.first);
  }

  @override
  Future<int> deleteEntryById(int id) async {
    final Database db = await _getDatabase();
    return await db.delete(_ENTRIES_TABLE, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Entry>> getEntriesByProjectId(int projectId) async {
    final Database db = await _getDatabase();

    final entriesAsMap = await db
        .query(_ENTRIES_TABLE, where: 'projectId = ?', whereArgs: [projectId]);

    if (entriesAsMap.isEmpty) return [];

    return entriesAsMap.map((entryAsMap) {
      return Entry.fromMap(entryAsMap);
    }).toList();
  }

  int _createNextProjectId() {
    final random = Random();
    int id = random.nextInt(10000).abs();
    while (_activeProjectIds.contains(id)) {
      id = random.nextInt(10000).abs();
    }
    _activeProjectIds.add(id);
    return id;
  }

  int _createNextEntryId() {
    final random = Random();
    int id = random.nextInt(_MAX_ID).abs();
    while (_activeEntryIds.contains(id)) {
      id = random.nextInt(_MAX_ID).abs();
    }
    _activeEntryIds.add(id);
    return id;
  }
}
