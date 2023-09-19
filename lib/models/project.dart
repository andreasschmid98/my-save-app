class Project {
  final int id;
  final String title;
  final double savingsGoal;
  final DateTime createdAt;

  Project({
    required this.id,
    required this.title,
    required this.savingsGoal,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
        id: map['id'] as int,
        title: map['title'] as String,
        savingsGoal: map['savingsGoal'] as double,
        createdAt: DateTime.parse(map['createdAt'] as String));
  }

  Map<String, Object> toMap() {
    return {
      'id': id,
      'title': title,
      'savingsGoal': savingsGoal,
      'createdAt': createdAt.toString()
    };
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(other) => other is Project && id == other.id;
}
