import 'package:flutter/material.dart';
import 'package:instagram_clone/views/feed_screen.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
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

// {
// "users": [
// {
// "uid": "u12345",
// "photoUrl": "https://randomuser.me/api/portraits/men/1.jpg",
// "username": "john_doe"
// },
// {
// "uid": "u12346",
// "photoUrl": "https://randomuser.me/api/portraits/women/2.jpg",
// "username": "jane_smith"
// },
// {
// "uid": "u12347",
// "photoUrl": "https://randomuser.me/api/portraits/men/3.jpg",
// "username": "mark_jones"
// },
// {
// "uid": "u12348",
// "photoUrl": "https://randomuser.me/api/portraits/women/4.jpg",
// "username": "emily_davis"
// },
// {
// "uid": "u12349",
// "photoUrl": "https://randomuser.me/api/portraits/men/5.jpg",
// "username": "alex_brown"
// },
// {
// "uid": "u12350",
// "photoUrl": "https://randomuser.me/api/portraits/women/6.jpg",
// "username": "sophia_wilson"
// },
// {
// "uid": "u12351",
// "photoUrl": "https://randomuser.me/api/portraits/men/7.jpg",
// "username": "michael_miller"
// },
// {
// "uid": "u12352",
// "photoUrl": "https://randomuser.me/api/portraits/women/8.jpg",
// "username": "chloe_taylor"
// }
// ]
// }




// {
// "posts": [
// {
// "id": "1",
// "type": "image",
// "mediaUrl": "https://www.w3schools.com/w3images/fjords.jpg",
// "caption": "A breathtaking view of the sunset at the beach, the perfect way to end the day. The sky was filled with vibrant colors, and the waves gently touched the shore as the sun slowly disappeared beyond the horizon. A truly magical moment!",
// "likes": 120,
// "comments": 5,
// "shares": 10,
// "carouselImages": []
// },
// {
// "id": "2",
// "type": "video",
// "mediaUrl": "https://www.w3schools.com/html/mov_bbb.mp4",
// "caption": "Watch this incredible video showcasing the beauty of nature, as the video captures a calm and peaceful river flowing through lush green landscapes. This is the kind of tranquility we all need in our busy lives. Don't miss it!",
// "likes": 250,
// "comments": 20,
// "shares": 50,
// "carouselImages": []
// },
// {
// "id": "3",
// "type": "carousel",
// "mediaUrl": "",
// "caption": "Join me on an unforgettable journey to the mountains. The majestic peaks, covered in snow, stood tall and proud as we trekked through the serene forests below. The fresh air and breathtaking views made every step worth it. Check out the photos from this adventure!",
// "likes": 180,
// "comments": 12,
// "shares": 30,
// "carouselImages": [
// "https://www.w3schools.com/w3images/fjords.jpg",
// "https://www.w3schools.com/w3images/mountains.jpg",
// "https://www.w3schools.com/w3images/lights.jpg"
// ]
// }
// ]
// }
