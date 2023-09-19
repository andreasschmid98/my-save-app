class Entry {
  final int id;
  final int projectId;
  final String description;
  final double saved;
  final DateTime createdAt;

  Entry({
    required this.id,
    required this.projectId,
    required this.description,
    required this.saved,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
        id: map['id'] as int,
        projectId: map['projectId'] as int,
        description: map['description'] as String,
        saved: map['saved'] as double,
        createdAt: DateTime.parse(map['createdAt'] as String));
  }

  Map<String, Object> toMap() {
    return {
      'id': id,
      'description': description,
      'saved': saved,
      'projectId': projectId,
      'createdAt': createdAt.toString()
    };
  }
}
