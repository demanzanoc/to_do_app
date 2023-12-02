import 'package:flutter/cupertino.dart';
import 'package:to_do_app/domain/to_do/entities/to_do.dart';
import 'package:to_do_app/domain/to_do/use_cases/get_to_do_list_use_case.dart';
import 'package:to_do_app/domain/utils/string_to_datetime_extension.dart';
import 'package:to_do_app/presentation/shared/providers/request_state.dart';
import 'package:to_do_app/presentation/to_do/providers/input_form_state.dart';
import '../../../domain/to_do/use_cases/set_to_do_use_case.dart';
import '../../../domain/login/use_cases/get_current_user_id_use_case.dart';

class ToDoProvider extends ChangeNotifier {
  final SetToDoUseCase setToDoUseCase;
  final GetCurrentUserIdUseCase getCurrentUserIdUseCase;
  final GetToDoListUseCase getToDoListUseCase;
  InputFormState _formState = InputFormState.initial;
  RequestState _toDoSetState = RequestState.initial;
  List<ToDo> _toDoList = [];

  ToDoProvider({
    required this.setToDoUseCase,
    required this.getCurrentUserIdUseCase,
    required this.getToDoListUseCase,
  });

  InputFormState get formState => _formState;
  RequestState get toDoSetState => _toDoSetState;
  List<ToDo> get toDoList => _toDoList;

  Future<void> setToDo(String title, String description, String date) async {
    _validateFields(title, description, date);
    if (_formState == InputFormState.completed) {
      _toDoSetState = RequestState.loading;
      notifyListeners();
      try {
        final userId = await getCurrentUserIdUseCase.call();
        if (userId.isNotEmpty) {
          final toDo = _createToDoEntity(title, description, date);
          await setToDoUseCase.call(userId, toDo);
          _toDoSetState = RequestState.success;
        }
      } catch (_) {
        _toDoSetState = RequestState.error;
      } finally {
        notifyListeners();
      }
    }
  }

  Future<void> getToDoList() async {
    try {
      final userId = await getCurrentUserIdUseCase.call();
      if (userId.isNotEmpty) {
        final toDoListResponse = getToDoListUseCase.call(userId);
        toDoListResponse.listen((toDos) {
          _toDoList = toDos;
        });
      }
    } catch (exception) {
      throw Exception(exception);
    }
  }

  void _validateFields(String title, String description, String date) {
    if (title.isNotEmpty && description.isNotEmpty && date.isNotEmpty) {
      _formState = InputFormState.completed;
      notifyListeners();
    } else {
      _formState = InputFormState.incomplete;
      notifyListeners();
    }
  }

  ToDo _createToDoEntity(String title, String description, String date) => ToDo(
        title: title,
        description: description,
        date: date.toDateTime(),
      );

  void resetState() {
    _toDoSetState = RequestState.initial;
    _formState = InputFormState.initial;
    notifyListeners();
  }

}
