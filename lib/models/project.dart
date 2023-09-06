class Project {
  final String id;
  final String title;
  final double savingsGoal;

  Project({required this.id, required this.title, required this.savingsGoal});

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
        id: map['id'] as String,
        title: map['title'] as String,
        savingsGoal: map['savings_goal'] as double);
  }



}
