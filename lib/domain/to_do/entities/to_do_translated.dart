import 'package:equatable/equatable.dart';

class ToDoTranslated extends Equatable {
  final String title;
  final String description;

  const ToDoTranslated({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}
