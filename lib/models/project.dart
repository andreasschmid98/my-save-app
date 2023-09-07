class Project {
  final int id;
  final String title;
  final double savingsGoal;

  Project({required this.id, required this.title, required this.savingsGoal});

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
        id: map['id'] as int,
        title: map['title'] as String,
        savingsGoal: map['savingsGoal'] as double);
  }

  Map<String, Object> toMap() {
    return {'id': id, 'title': title, 'savingsGoal': savingsGoal};
  }
}
