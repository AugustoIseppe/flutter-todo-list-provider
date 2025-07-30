import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_page.dart';

import '../../core/modules/todo_list_module.dart';
import 'login/login_controller.dart';
import 'login/login_page.dart';
import 'register/register_controller.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(bindings: [
          ChangeNotifierProvider(
            create: (context) => LoginController(userService: context.read()),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                RegisterController(userService: context.read()),
          ),
        ], routers: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
        });
}
