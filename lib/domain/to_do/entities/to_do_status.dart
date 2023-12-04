enum ToDoStatus {
  toDo,
  inProgress,
  done,
}

extension ToDoStatusExtension on String {
  ToDoStatus toToDoStatus() {
    return ToDoStatus.values.firstWhere(
      (item) => item.toString().split('.')[1] == this,
      orElse: () => ToDoStatus.toDo,
    );
  }
}
