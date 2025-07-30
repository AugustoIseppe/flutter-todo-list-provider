import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/modules/task/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/task/widgets/calendar_button.dart';
import 'package:todo_list_provider/app/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/widget/todo_list_logo.dart';
import 'package:validatorless/validatorless.dart';

class TaskCreatePage extends StatefulWidget {
  final TaskCreateController _controller;

  const TaskCreatePage({super.key, required TaskCreateController controller})
      : _controller = controller;

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final _descriptioEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(
      changeNotifier: widget._controller,
    ).listener(
        context: context,
        successCallback: (notifier, listenerInstance) {
          listenerInstance.dispose();
          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.close, color: Colors.blue[900], size: 30),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        elevation: 20,
        onPressed: () {
          final formValid = _formKey.currentState!.validate();
          if (formValid) {
            widget._controller.save(_descriptioEC.text);
          }
        },
        label: Text(
          'Salvar',
          style:
              TextStyle(color: Colors.blue[900], fontWeight: FontWeight.w900),
        ),
        icon: Icon(
          Icons.save,
          color: Colors.blue[900],
        ),
      ),
      body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Align(alignment: Alignment.center, child: TodoListLogo()),
                const SizedBox(height: 20),
                const Text(
                  'Nova tarefa',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                TodoListField(
                  label: 'Título',
                  controller: _descriptioEC,
                  validator: Validatorless.required('Campo obrigatório'),
                ),
                const SizedBox(height: 20),
                CalendarButton(),
              ],
            ),
          )),
    );
  }
}
