class TaskModel {
  String id;
  String title;
  String description;
  DateTime startDateTime;
  DateTime stopDateTime;
  bool completed;
  String priority; // New priority field

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDateTime,
    required this.stopDateTime,
    this.completed = false,
    this.priority = 'Normal', // Default priority value
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'startDateTime': startDateTime?.toIso8601String(),
      'stopDateTime': stopDateTime?.toIso8601String(),
      'priority': priority, // Added priority to JSON map
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
      startDateTime: DateTime.parse(json['startDateTime']),
      stopDateTime: DateTime.parse(json['stopDateTime']),
      priority: json['priority'] ?? 'Normal', // Added default priority handling
    );
  }
  // The copyWith method
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDateTime,
    DateTime? stopDateTime,
    bool? completed,
    String? priority,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDateTime: startDateTime ?? this.startDateTime,
      stopDateTime: stopDateTime ?? this.stopDateTime,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
    );
  }

  @override
  String toString() {
    return 'TaskModel{id: $id, title: $title, description: $description, '
        'startDateTime: $startDateTime, stopDateTime: $stopDateTime, '
        'completed: $completed, priority: $priority}'; // Included priority in toString
  }
}


List<TaskModel> dummyTasks = [
  TaskModel(
    id: 'task_1',
    title: 'Finish Flutter project',
    description: 'Complete the Flutter app for client review.',
    startDateTime: DateTime(2025, 3, 18, 10, 0),
    stopDateTime: DateTime(2025, 3, 18, 12, 0),
    completed: false,
  ),
  TaskModel(
    id: 'task_2',
    title: 'Design UI for new feature',
    description: 'Create the UI design for the new feature.',
    startDateTime: DateTime(2025, 3, 18, 9, 30),
    stopDateTime: DateTime(2025, 3, 18, 11, 30),
    completed: true,
  ),
  TaskModel(
    id: 'task_3',
    title: 'Bug Fix: Navigation Issue',
    description: 'Fix the issue with navigation in the app.',
    startDateTime: DateTime(2025, 3, 17, 14, 0),
    stopDateTime: DateTime(2025, 3, 17, 16, 0),
    completed: true,
  ),
  TaskModel(
    id: 'task_4',
    title: 'Prepare meeting agenda',
    description: 'Draft the agenda for tomorrow’s meeting with stakeholders.',
    startDateTime: DateTime(2025, 3, 19, 8, 0),
    stopDateTime: DateTime(2025, 3, 19, 9, 0),
    completed: false,
  ),
  TaskModel(
    id: 'task_5',
    title: 'Code review for the new feature',
    description: 'Conduct a code review for the newly added feature.',
    startDateTime: DateTime(2025, 3, 19, 11, 0),
    stopDateTime: DateTime(2025, 3, 19, 12, 30),
    completed: false,
  ),
  TaskModel(
    id: 'task_6',
    title: 'Write documentation for API',
    description: 'Write the API documentation for the upcoming release.',
    startDateTime: DateTime(2025, 3, 20, 13, 0),
    stopDateTime: DateTime(2025, 3, 20, 15, 0),
    completed: false,
  ),
  TaskModel(
    id: 'task_7',
    title: 'Update app dependencies',
    description: 'Update dependencies for the app to the latest versions.',
    startDateTime: DateTime(2025, 3, 21, 9, 0),
    stopDateTime: DateTime(2025, 3, 21, 11, 0),
    completed: true,
  ),
  TaskModel(
    id: 'task_8',
    title: 'Write unit tests for new feature',
    description: 'Write unit tests to ensure the new feature is working properly.',
    startDateTime: DateTime(2025, 3, 22, 10, 0),
    stopDateTime: DateTime(2025, 3, 22, 12, 0),
    completed: false,
  ),
  TaskModel(
    id: 'task_9',
    title: 'Setup production environment',
    description: 'Set up the production environment for the new release.',
    startDateTime: DateTime(2025, 3, 23, 14, 0),
    stopDateTime: DateTime(2025, 3, 23, 16, 0),
    completed: false,
  ),
  TaskModel(
    id: 'task_10',
    title: 'Test user authentication flow',
    description: 'Ensure that the user authentication flow works smoothly.',
    startDateTime: DateTime(2025, 3, 24, 16, 0),
    stopDateTime: DateTime(2025, 3, 24, 18, 0),
    completed: true,
  ),
];
