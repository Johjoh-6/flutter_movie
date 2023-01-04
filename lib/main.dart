import 'package:flutter/material.dart';
import 'package:movie_list/login.dart';
import 'package:movie_list/movie/movies_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie list',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/': (_) => new LoginPage(),
        '/home': (_) => new MoviesList(),
      },
    );
  }
}
