import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
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
        )
      ),
      title: "Instagram",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset("assets/images/insta_logo.png",width:160),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
            SizedBox(width: 5),
            IconButton(onPressed: (){}, icon: Icon(Icons.chat_bubble_outline)),
            SizedBox(width: 5),
          ],
        ),
        bottomNavigationBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled,color: Colors.black,),label: '',),
          BottomNavigationBarItem(icon: Icon(Icons.search,color: Colors.black),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline,color: Colors.black),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.video_collection_outlined,color: Colors.black),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined,color: Colors.black),label: '')
        ]),
      ),
    );
  }

}
