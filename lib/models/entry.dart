class Entry {
  final int id;
  final int projectId;
  final String description;
  final double saved;

  Entry(
      {required this.id,
      required this.projectId,
      required this.description,
      required this.saved});

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
        id: map['id'] as int,
        projectId: map['projectId'] as int,
        description: map['description'] as String,
        saved: map['saved'] as double);
  }

  Map<String, Object> toMap() {
    return {
      'id': id,
      'description': description,
      'saved': saved,
      'projectId': projectId
    };
  }
}
