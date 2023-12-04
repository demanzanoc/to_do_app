import 'package:to_do_app/domain/to_do/entities/to_do_translated.dart';

class ToDoTranslatedModel extends ToDoTranslated {
  const ToDoTranslatedModel({
    required super.title,
    required super.description,
  });

  factory ToDoTranslatedModel.fromApiModel(
    Map<String, dynamic> toDoTranslated,
  ) =>
      ToDoTranslatedModel(
        title: toDoTranslated['translatedTitle'],
        description: toDoTranslated['translatedDescription'],
      );
}
