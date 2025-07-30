import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  final connection = SqliteConnectionFactory();

  // didChangeAppLifecycleState: Método que é chamado quando o estado do aplicativo muda
  // (ex: quando o aplicativo é pausado, quando o aplicativo é retomado, etc).
  // Com isso, é possível fechar a conexão com o banco de dados quando o aplicativo é pausado, por exemplo.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;
      case AppLifecycleState.hidden:
        break;
    }

    super.didChangeAppLifecycleState(state);
  }
}
