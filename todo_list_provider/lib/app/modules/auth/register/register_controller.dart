import 'package:todo_list_provider/app/exceptions/auth_exception.dart';

import '../../../core/notifier/default_change_notifier.dart';
import '../../../services/user/user_service.dart';

//! 5 - Crie uma classe chamada RegisterController que estende ChangeNotifier.
class RegisterController extends DefaultChangeNotifier {
  final UserService _userService;

  RegisterController({required UserService userService})
      : _userService = userService;

  void registerUser(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        //success
        success();
      } else {
        //error
        setError('Erro ao registrar usuário');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
