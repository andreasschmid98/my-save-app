import '../models/entry.dart';

abstract class EntryRepository {

  Future<List<Entry>> getEntriesByProjectId(int projectId);

  Future<Entry> createEntry(String description, int projectId, double saved);

  Future<int> deleteEntryById(int id);

  Future<Entry> getEntryById(int id);

}