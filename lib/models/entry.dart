import 'package:my_save_app/factories/frequency_factory.dart';
import 'package:my_save_app/models/frequency.dart';

class Entry {
  final int id;
  final int projectId;
  final String description;
  final double saved;
  final DateTime createdAt;
  final Frequency frequency;

  Entry({
    required this.id,
    required this.projectId,
    required this.description,
    required this.saved,
    Frequency? frequency,
    DateTime? createdAt,
  })  : frequency = frequency ?? Frequency.SINGLE,
        createdAt = createdAt ?? DateTime.now();

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
        id: map['id'] as int,
        projectId: map['projectId'] as int,
        description: map['description'] as String,
        saved: map['saved'] as double,
        frequency: FrequencyFactory.create(map['frequency']),
        createdAt: DateTime.parse(map['createdAt'] as String));
  }

  Map<String, Object> toMap() {
    return {
      'id': id,
      'description': description,
      'saved': saved,
      'projectId': projectId,
      'frequency': frequency.index,
      'createdAt': createdAt.toString()
    };
  }
}
