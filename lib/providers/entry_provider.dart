
import 'package:flutter/material.dart';

import '../models/entry.dart';
import '../repositories/entry_repository.dart';
import '../services/database_service.dart';

class EntryProvider with ChangeNotifier {

  final EntryRepository _entryRepository = DatabaseService.instance;
  List<Entry> currentEntries = [];

  void setCurrentEntries(int projectId) async {
    currentEntries = await _entryRepository.getEntriesByProjectId(projectId);
  }

  Future<void> createEntry(String description, int projectId, double saved) async {
    await _entryRepository.createEntry(description, projectId, saved);
    currentEntries = await _entryRepository.getEntriesByProjectId(projectId);
    notifyListeners();
  }

}