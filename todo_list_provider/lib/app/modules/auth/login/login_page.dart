import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:todo_list_provider/app/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/widget/todo_list_logo.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
            context: context,
            everCallback: (notifier, listenerInstance) {
              if (notifier is LoginController) {
                if (notifier.hasInfo) {
                  Messages.of(context).showInfo(notifier.infoMessage!);
                }
              }
            },
            successCallback: (notifier, listenerInstance) {
              debugPrint('LOGIN SUCESS');
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  const TodoListLogo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TodoListField(
                            focusNode: _emailFocus,
                            label: 'Email',
                            controller: _emailEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('E=mail obrigatório'),
                              Validatorless.email('Email inválido'),
                            ]),
                          ),
                          const SizedBox(height: 10),
                          TodoListField(
                            label: 'Senha',
                            obscureText: true,
                            controller: _passwordEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatória'),
                              Validatorless.min(
                                  6, 'A senha deve ter no mínimo 6 caracteres'),
                            ]),
                          ),
                          Row(
                            children: [
                              FilledButton(
                                  onPressed: () {
                                    if (_emailEC.text.isNotEmpty) {
                                      //Recuperar senha
                                      context
                                          .read<LoginController>()
                                          .forgotPassword(
                                            _emailEC.text,
                                          );
                                    } else {
                                      _emailFocus.requestFocus();
                                      Messages.of(context).showError(
                                        'Informe o email para recuperar a senha',
                                      );
                                    }
                                  },
                                  child: const Text('Recuperar senha')),
                              const Spacer(),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      context.primaryColorLight),
                                ),
                                onPressed: () {
                                  final formValid =
                                      _formKey.currentState!.validate();
                                  if (formValid) {
                                    final email = _emailEC.text;
                                    final password = _passwordEC.text;
                                    context.read<LoginController>().login(
                                          email,
                                          password,
                                        );
                                  }
                                },
                                child: Text(
                                  'Login',
                                  style:
                                      TextStyle(color: Colors.deepPurple[900]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF0F3F7),
                        border: Border(
                          top: BorderSide(color: Colors.grey.withAlpha(50)),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SignInButton(
                            Buttons.Google,
                            text: "Sign up with Google",
                            onPressed: () {
                              context.read<LoginController>().googleLogin();
                            },
                          ),
                          SignInButtonBuilder(
                            text: 'Sign in with Email',
                            icon: Icons.email,
                            onPressed: () {},
                            backgroundColor: Colors.blueGrey[700]!,
                          ),
                          SignInButton(
                            Buttons.Facebook,
                            mini: false,
                            onPressed: () {},
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Não tem uma conta?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text(
                                  'Cadastre-se',
                                  style:
                                      TextStyle(color: Colors.deepPurple[900]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
