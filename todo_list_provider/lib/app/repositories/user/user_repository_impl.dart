import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_provider/app/exceptions/auth_exception.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

//!2 - Crie uma classe concreta chamada UserRepositoryImpl que implementa UserRepository.
class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());

      if (e.code == 'weak-password') {
        throw AuthException(message: 'A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(message: 'Este e-mail já está cadastrado.');
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw AuthException(message: 'Erro ao registrar usuário');
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());

      if (e.code == 'wrong-password') {
        throw AuthException(message: 'Senha incorreta');
      } else if (e.code == 'invalid-credential') {
        throw AuthException(message: 'Usuário ou senha inválidos');
      } else if (e.code == 'user-not-found') {
        throw AuthException(message: 'Usuário não encontrado');
      } else {
        throw AuthException(message: e.message ?? 'Erro ao fazer login');
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw AuthException(message: 'Erro ao fazer login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(message: 'E-mail não cadastrado');
      } else if (e.code == 'invalid-email') {
        throw AuthException(message: 'E-mail inválido');
      } else {
        throw AuthException(message: 'Erro ao recuperar senha');
      }
    } catch (e) {
      throw AuthException(message: 'Erro ao recuperar senha');
    }
  }

  @override
  Future<User?> googleLogin() async {
    //! Problema: o GoogleSignIn esta sobrescrevendo o usuário logado com o Firebase com email e senha.
    //! Procurar alguma solução para isso.
    try {
      // await logout();
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
          message: 'Este e-mail já está cadastrado com outro provedor. '
              'Faça login com o método original primeiro!',
        );
      } else {
        throw AuthException(message: 'Erro no Google Login: ${e.message}');
      }
    } catch (e) {
      throw AuthException(message: 'Erro ao fazer login com Google.');
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    } else {
      throw AuthException(message: 'Usuário não encontrado');
    }
  }
}
