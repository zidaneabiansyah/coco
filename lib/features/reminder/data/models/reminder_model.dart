import 'package:hive/hive.dart';
import 'package:coco/features/reminder/domain/entities/reminder_entity.dart';

part 'reminder_model.g.dart';

/// Reminder Model (Data Layer)
/// Hive model for local database storage
/// Maps between database and domain entity
@HiveType(typeId: 0)
class ReminderModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime dateTime;

  @HiveField(4)
  final String? location;

  @HiveField(5)
  final int category; // Store enum as int

  @HiveField(6)
  final int priority; // Store enum as int

  @HiveField(7)
  final int repeat; // Store enum as int

  @HiveField(8)
  final int status; // Store enum as int

  @HiveField(9)
  final DateTime createdAt;

  @HiveField(10)
  final DateTime updatedAt;

  @HiveField(11)
  final bool isNotificationEnabled;

  @HiveField(12)
  final List<String>? tags;

  ReminderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    this.location,
    required this.category,
    required this.priority,
    required this.repeat,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.isNotificationEnabled = true,
    this.tags,
  });

  /// Convert from Entity to Model
  factory ReminderModel.fromEntity(ReminderEntity entity) {
    return ReminderModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      dateTime: entity.dateTime,
      location: entity.location,
      category: entity.category.index,
      priority: entity.priority.index,
      repeat: entity.repeat.index,
      status: entity.status.index,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isNotificationEnabled: entity.isNotificationEnabled,
      tags: entity.tags,
    );
  }

  /// Convert from Model to Entity
  ReminderEntity toEntity() {
    return ReminderEntity(
      id: id,
      title: title,
      description: description,
      dateTime: dateTime,
      location: location,
      category: ReminderCategory.values[category],
      priority: ReminderPriority.values[priority],
      repeat: ReminderRepeat.values[repeat],
      status: ReminderStatus.values[status],
      createdAt: createdAt,
      updatedAt: updatedAt,
      isNotificationEnabled: isNotificationEnabled,
      tags: tags,
    );
  }

  /// Convert to JSON (for backup/export purposes)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
      'category': category,
      'priority': priority,
      'repeat': repeat,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isNotificationEnabled': isNotificationEnabled,
      'tags': tags,
    };
  }

  /// Convert from JSON (for backup/import purposes)
  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      location: json['location'] as String?,
      category: json['category'] as int,
      priority: json['priority'] as int,
      repeat: json['repeat'] as int,
      status: json['status'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isNotificationEnabled: json['isNotificationEnabled'] as bool? ?? true,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
    );
  }

  /// Copy with method
  ReminderModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dateTime,
    String? location,
    int? category,
    int? priority,
    int? repeat,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isNotificationEnabled,
    List<String>? tags,
  }) {
    return ReminderModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      repeat: repeat ?? this.repeat,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isNotificationEnabled:
          isNotificationEnabled ?? this.isNotificationEnabled,
      tags: tags ?? this.tags,
    );
  }

  @override
  String toString() {
    return 'ReminderModel(id: $id, title: $title, dateTime: $dateTime, status: $status)';
  }
}
