import 'package:firebase_auth/firebase_auth.dart';

//!3 - Crie uma classe abstrata chamada UserService.
abstract class UserService {
  Future<User?> register(String email, String password);
  Future<User?> login(String email, String password);
  Future<void> forgotPassword(String email);
  Future<User?> googleLogin();
  Future<void> logout();
  Future<void> updateDisplayName(String displayName);
}
