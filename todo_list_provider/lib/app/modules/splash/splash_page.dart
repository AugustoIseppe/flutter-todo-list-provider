import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/widget/todo_list_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SplashPage'),
      ),
      body: const Center(
        child: Column(
          children: [
            TodoListLogo(),
            Text('SplashPage'),
          ],
        ),
      ),
    );
  }
}
