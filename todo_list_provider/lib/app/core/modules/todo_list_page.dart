import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class TodoListPage extends StatelessWidget {
  final List<SingleChildWidget> _bindings;
  final WidgetBuilder _page;

  TodoListPage({
    super.key,
    List<SingleChildWidget>? bindings,
    required WidgetBuilder? page,
  })  : _bindings = bindings ??
            [Provider(create: (_) => Object())], // Garante que nunca seja vazio
        _page = page!;

  @override
  Widget build(BuildContext context) {
    return _bindings.isNotEmpty
        ? MultiProvider(
            providers: _bindings,
            child: Builder(builder: (context) => _page(context)),
          )
        : _page(
            context); // Renderiza a página normalmente se não houver bindings
  }
}
