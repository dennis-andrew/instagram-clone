import 'package:flutter/material.dart';
import 'package:instagram_clone/views/feed_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
          brightness: Brightness.light,
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
              foregroundColor: Colors.black,
              iconSize: 30,
            ),
          )),
      title: "Instagram",
      debugShowCheckedModeBanner: false,
      home: FeedScreen()
    );
  }
}
