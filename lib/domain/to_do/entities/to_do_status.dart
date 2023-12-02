enum ToDoStatus {
  toDo,
  inProgress,
  done,
}

extension ToDoStatusExtension on String {
  static ToDoStatus fromString(String status) {
    return ToDoStatus.values.firstWhere(
      (item) => item.toString().toLowerCase() == status.toLowerCase(),
      orElse: () => ToDoStatus.toDo,
    );
  }
}
