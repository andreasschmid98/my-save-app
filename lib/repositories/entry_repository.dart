import 'package:my_save_app/models/frequency.dart';

import '../models/entry.dart';

abstract class EntryRepository {
  Future<List<Entry>> getEntriesByProjectId(int projectId);

  Future<Entry> createEntry(String description, int projectId, double saved, Frequency frequency, DateTime startingDate);

  Future<int> deleteEntryById(int id);

  Future<Entry> getEntryById(int id);
}
