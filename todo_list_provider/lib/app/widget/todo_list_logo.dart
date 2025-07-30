import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Image.asset('assets/logo.jpg', height: 200),
        Text('Todo List',
            style: GoogleFonts.abel(
                textStyle: Theme.of(context).textTheme.titleLarge)),
      ],
    );
  }
}
