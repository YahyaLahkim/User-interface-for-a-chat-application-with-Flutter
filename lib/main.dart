import 'package:flutter/material.dart';
import 'pages/home_test.dart';
//import 'pages/chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Définition des couleurs principales pour tout le projet
  static const Color primaryColor = Color(0xFF2196F3); // bleu
  static const Color backgroundColor = Color(0xFF121212); // noir foncé
  static const Color textColor = Colors.white;
  static const Color unselectedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: textColor,
          elevation: 2,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: backgroundColor,
          selectedItemColor: textColor,
          unselectedItemColor: unselectedColor,
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: textColor,
          displayColor: textColor,
        ),
      ),
      home:  HomePage(),
    );
  }
}
