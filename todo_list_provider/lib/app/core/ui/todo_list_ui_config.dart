import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();

  static ThemeData get themeData => ThemeData(
        textTheme: GoogleFonts.mandaliTextTheme(),
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        primaryColorLight: Colors.deepPurple[100],
        primaryColorDark: Colors.deepPurple[900],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.deepPurple[900]),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.orange[900]),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurple[900],
          textTheme: ButtonTextTheme.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
}
