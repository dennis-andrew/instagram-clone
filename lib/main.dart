import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset("assets/images/insta_logo.png", height: 60),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
            SizedBox(width: 5),
            IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_outline)),
            SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      8,
                      (index) {
                        return Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                      "assets/images/insta_story.png"),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        "assets/images/insta_logo.png"),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Profile Name",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black87),
                                )
                              ],
                            ));
                      },
                    ),
                  )),
              Divider(),
              Column(
                  children: List.generate(
                8,
                (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundImage:
                                AssetImage("assets/images/insta_story.png"),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage:
                                  AssetImage("assets/images/insta_logo.png"),
                            ),
                          ),
                        ),
                        Text("Profile"),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {},
                        )
                      ]),
                      Image.asset("assets/images/insta_logo.png"),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.chat_bubble_outline),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.label_outline),
                            onPressed: () {},
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.bookmark_border),
                            onPressed: () {},
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                  TextSpan(text: 'Liked by'),
                                  TextSpan(
                                      text: ' Profile Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: " and"),
                                  TextSpan(
                                      text: ' others',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ])),
                            SizedBox(height: 10,),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                  TextSpan(
                                    text: " Profile Name",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text:
                                          " Had fun yesterday at the amazing theatre..Looking forward to more times like this!"),
                                ])),
                            SizedBox(height:10),
                            Text("View all 43 comments",
                                style: TextStyle(color: Colors.black38))
                          ],
                        ),
                      )
                    ],
                  );
                },
              ))
            ],
          ),
        ),
        bottomNavigationBar:
            CupertinoTabBar(height: 80, activeColor: Colors.black, items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: Colors.black,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.black), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline, color: Colors.black),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_collection_outlined, color: Colors.black),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined, color: Colors.black),
              label: '')
        ]),
      ),
    );
  }
}
