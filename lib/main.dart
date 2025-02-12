import 'package:flutter/material.dart';
import 'package:instagram_clone/views/feed_screen.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          themeMode: ThemeMode.light,
          theme: ThemeData(
              brightness: Brightness.light,
              iconButtonTheme: IconButtonThemeData(
                style: IconButton.styleFrom(
                  foregroundColor: Colors.black,
                  iconSize: 30.sp,
                ),
              )),
          title: "Instagram",
          debugShowCheckedModeBanner: false,
          home: FeedScreen(),
        );
      },
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



// {
// "users": [
// {
// "uid": "u12353",
// "photoUrl": "https://randomuser.me/api/portraits/men/10.jpg",
// "username": "david_moore"
// },
// {
// "uid": "u12354",
// "photoUrl": "https://randomuser.me/api/portraits/women/11.jpg",
// "username": "olivia_johnson"
// },
// {
// "uid": "u12355",
// "photoUrl": "https://randomuser.me/api/portraits/men/12.jpg",
// "username": "chris_taylor"
// },
// {
// "uid": "u12356",
// "photoUrl": "https://randomuser.me/api/portraits/women/13.jpg",
// "username": "lucy_king"
// },
// {
// "uid": "u12357",
// "photoUrl": "https://randomuser.me/api/portraits/men/14.jpg",
// "username": "benjamin_clark"
// },
// {
// "uid": "u12358",
// "photoUrl": "https://randomuser.me/api/portraits/women/15.jpg",
// "username": "ella_scott"
// },
// {
// "uid": "u12359",
// "photoUrl": "https://randomuser.me/api/portraits/men/16.jpg",
// "username": "william_anderson"
// },
// {
// "uid": "u12360",
// "photoUrl": "https://randomuser.me/api/portraits/women/17.jpg",
// "username": "isabella_lee"
// },
// {
// "uid": "u12361",
// "photoUrl": "https://randomuser.me/api/portraits/men/18.jpg",
// "username": "samuel_thompson"
// },
// {
// "uid": "u12362",
// "photoUrl": "https://randomuser.me/api/portraits/women/19.jpg",
// "username": "martha_walker"
// },
// {
// "uid": "u12363",
// "photoUrl": "https://randomuser.me/api/portraits/men/20.jpg",
// "username": "joseph_rodriquez"
// },
// {
// "uid": "u12364",
// "photoUrl": "https://randomuser.me/api/portraits/women/21.jpg",
// "username": "charlotte_young"
// },
// {
// "uid": "u12365",
// "photoUrl": "https://randomuser.me/api/portraits/men/22.jpg",
// "username": "ethan_harris"
// },
// {
// "uid": "u12366",
// "photoUrl": "https://randomuser.me/api/portraits/women/23.jpg",
// "username": "ella_martin"
// },
// {
// "uid": "u12367",
// "photoUrl": "https://randomuser.me/api/portraits/men/24.jpg",
// "username": "oliver_wright"
// },
// {
// "uid": "u12368",
// "photoUrl": "https://randomuser.me/api/portraits/women/25.jpg",
// "username": "grace_lee"
// },
// {
// "uid": "u12369",
// "photoUrl": "https://randomuser.me/api/portraits/men/26.jpg",
// "username": "henry_jones"
// },
// {
// "uid": "u12370",
// "photoUrl": "https://randomuser.me/api/portraits/women/27.jpg",
// "username": "chloe_martinez"
// },
// {
// "uid": "u12371",
// "photoUrl": "https://randomuser.me/api/portraits/men/28.jpg",
// "username": "matthew_garcia"
// },
// {
// "uid": "u12372",
// "photoUrl": "https://randomuser.me/api/portraits/women/29.jpg",
// "username": "scarlett_hernandez"
// },
// {
// "uid": "u12373",
// "photoUrl": "https://randomuser.me/api/portraits/men/30.jpg",
// "username": "alexander_martin"
// },
// {
// "uid": "u12374",
// "photoUrl": "https://randomuser.me/api/portraits/women/31.jpg",
// "username": "amelia_baker"
// },
// {
// "uid": "u12375",
// "photoUrl": "https://randomuser.me/api/portraits/men/32.jpg",
// "username": "james_davis"
// },
// {
// "uid": "u12376",
// "photoUrl": "https://randomuser.me/api/portraits/women/33.jpg",
// "username": "zoe_miller"
// },
// {
// "uid": "u12377",
// "photoUrl": "https://randomuser.me/api/portraits/men/34.jpg",
// "username": "daniel_rodriguez"
// },
// {
// "uid": "u12378",
// "photoUrl": "https://randomuser.me/api/portraits/women/35.jpg",
// "username": "eva_lopez"
// },
// {
// "uid": "u12379",
// "photoUrl": "https://randomuser.me/api/portraits/men/36.jpg",
// "username": "luke_white"
// },
// {
// "uid": "u12380",
// "photoUrl": "https://randomuser.me/api/portraits/women/37.jpg",
// "username": "natalie_garcia"
// },
// {
// "uid": "u12381",
// "photoUrl": "https://randomuser.me/api/portraits/men/38.jpg",
// "username": "ryan_perez"
// },
// {
// "uid": "u12382",
// "photoUrl": "https://randomuser.me/api/portraits/women/39.jpg",
// "username": "samantha_moore"
// },
// {
// "uid": "u12383",
// "photoUrl": "https://randomuser.me/api/portraits/men/40.jpg",
// "username": "charles_brown"
// },
// {
// "uid": "u12384",
// "photoUrl": "https://randomuser.me/api/portraits/women/41.jpg",
// "username": "lily_taylor"
// },
// {
// "uid": "u12385",
// "photoUrl": "https://randomuser.me/api/portraits/men/42.jpg",
// "username": "jackson_moore"
// },
// {
// "uid": "u12386",
// "photoUrl": "https://randomuser.me/api/portraits/women/43.jpg",
// "username": "emily_wilson"
// },
// {
// "uid": "u12387",
// "photoUrl": "https://randomuser.me/api/portraits/men/44.jpg",
// "username": "ryan_baker"
// }
// ]
// }