class Entry {
  final String id;
  final String projectId;
  final String description;
  final String owner;
  final double saved;

  Entry(
      {required this.id,
      required this.projectId,
      required this.description,
      required this.owner,
      required this.saved});

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      id: map['id'] as String,
      projectId: map['group_id'] as String,
      description: map['description'] as String,
      owner: map['owner'] as String,
      saved: map['saved'] as double,
    );
  }
}
