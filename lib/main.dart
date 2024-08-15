import 'package:flutter/material.dart';
import 'package:netflix_clone/views/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix Clone',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red[900],
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: Colors.red,
        ).copyWith(
          primary: Colors.red[900],
          secondary: Colors.grey[800],
          background: Colors.black,
          surface: Colors.black,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.white,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.red[900],
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red[900],
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        cardColor: Colors.grey[900],
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
