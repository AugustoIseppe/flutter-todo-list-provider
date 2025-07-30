import 'package:firebase_auth/firebase_auth.dart';

//! 1 - Inicie criando uma classe abstrata chamada UserRepository.
abstract class UserRepository {
  Future<User?> register(String email, String password);
  Future<User?> login(String email, String password);
  Future<void> forgotPassword(String email);
  Future<User?> googleLogin();
  Future<void> logout();
  Future<void> updateDisplayName(String name);
}
