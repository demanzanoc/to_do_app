import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/presentation/shared/providers/request_state.dart';
import 'package:to_do_app/presentation/login/widgets/input_text_field.dart';
import 'package:to_do_app/presentation/to_do/providers/input_form_state.dart';
import 'package:to_do_app/presentation/to_do/widgets/date_picker_field.dart';
import 'package:to_do_app/presentation/utils/simple_snack_bar.dart';
import '../../login/widgets/button.dart';
import '../../utils/progress_dialog.dart';
import '../providers/to_do_provider.dart';

class ToDoFormAlertDialog extends StatelessWidget {
  ToDoFormAlertDialog({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ToDoProvider toDoProvider = context.watch<ToDoProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _manageState(toDoProvider, context);
    });
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Crear tarea'),
          IconButton(
            icon: const Icon(
              Icons.close,
              size: 30,
              color: Colors.deepPurple,
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/2387/2387635.png',
              ),
            ),
            InputTextField(
              hintText: 'Tarea',
              controller: _titleController,
              icon: Icons.task_alt,
            ),
            InputTextField(
              hintText: 'Descripción',
              controller: _descriptionController,
              icon: Icons.description,
            ),
            DatePickerField(
              hintText: 'Fecha',
              controller: _dateController,
              onPressed: () => _onDatePickerPressed(context),
              icon: Icons.date_range,
            ),
          ],
        ),
      ),
      actions: [
        Button(
          text: 'Guardar',
          onPressed: () => toDoProvider.setToDo(
            _titleController.text,
            _descriptionController.text,
            _dateController.text,
          ),
        ),
      ],
    );
  }

  Future<void> _onDatePickerPressed(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (datePicked != null) {
      _dateController.text = '${datePicked.year}'
          '-${datePicked.month.toString().padLeft(2, '0')}'
          '-${datePicked.day.toString().padLeft(2, '0')}';
    }
  }

  void _manageState(ToDoProvider toDoProvider, BuildContext context) {
    if (toDoProvider.formState == InputFormState.incomplete) {
      SimpleSnackBar.show(context, message: 'Complete todos los campos');
    }
    switch (toDoProvider.toDoSetState) {
      case RequestState.initial:
        break;
      case RequestState.loading:
        ProgressDialog.show(context);
        break;
      case RequestState.success:
        _onToDoCreated(context, toDoProvider);
        break;
      case RequestState.error:
        _onToDoCreateError(context, toDoProvider);
        break;
      default:
        break;
    }
  }

  void _onToDoCreated(BuildContext context, ToDoProvider toDoProvider) {
    const String successLoginMessage = 'Tarea creada';
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    SimpleSnackBar.show(
      context,
      message: successLoginMessage,
    );
    toDoProvider.resetState();
  }

  void _onToDoCreateError(BuildContext context, ToDoProvider toDoProvider) {
    const String errorLoginMessage =
        'Ha ocurrido un error intentando crear la tarea';
    Navigator.of(context).pop();
    SimpleSnackBar.show(
      context,
      message: errorLoginMessage,
    );
    toDoProvider.resetState();
  }
}
