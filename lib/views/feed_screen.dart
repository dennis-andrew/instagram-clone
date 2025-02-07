import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'chat_screen.dart';

class FeedScreen extends StatelessWidget{
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/insta_logo.png", height: 60),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
          SizedBox(width: 5),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
          }, icon: ImageIcon(AssetImage("assets/images/messenger.png"),size: 32)),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stories Section
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

            // Posts Section
            Column(
              children: List.generate(
                5, // Create 6 posts
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
                      index % 3 == 0 // Check if it's a single image post
                          ? Image.asset("assets/images/insta_logo.png")
                          : index % 3 == 1 // Check if it's an image carousel
                          ? ImageCarousel()
                          : index % 3 == 2 // Check if it's a video post
                          ? VideoPost()
                          : SizedBox(),
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
                            SizedBox(height: 10),
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
                            SizedBox(height: 10),
                            Text("View all 43 comments",
                                style: TextStyle(color: Colors.black38))
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            )
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
            icon: ImageIcon(AssetImage("assets/images/video.png"),color: Colors.black,size: 26,),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, color: Colors.black),
            label: '')
      ]),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Carousel
        CarouselSlider(
          items: [
            Image.asset("assets/images/insta_logo.png"),
            Image.asset("assets/images/insta_story.png"),
            Image.asset("assets/images/insta_logo.png"),
          ],
          options: CarouselOptions(
            enableInfiniteScroll: false, // Disable infinite scroll
            enlargeCenterPage: true, // Center the current image
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            scrollPhysics: BouncingScrollPhysics(),
          ),
        ),

        // Image index (1/3, 2/3, etc.)
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5), // Translucent black background
              borderRadius: BorderRadius.circular(20), // Pill shape
            ),
            child: Text(
              '${_currentIndex + 1}/3',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),

        // Dots Indicator
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
                  (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Colors.blue
                      : Colors.grey, // Change color based on current image
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class VideoPost extends StatefulWidget {
  @override
  _VideoPostState createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isInitialized = false; // Flag to track video initialization

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the video URL
    _controller = VideoPlayerController.network(
        'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4') // New test video URL
      ..addListener(() {
        // Listen for initialization and changes
        if (_controller.value.isInitialized && !_isInitialized) {
          setState(() {
            _isInitialized = true;
          });
        }
      })
      ..initialize().then((_) {
        setState(() {}); // Rebuild when initialization is complete
      }).catchError((e) {
        // Handle errors in initialization
        print("Error initializing video: $e");
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Dispose the controller when done
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('video-post-key'),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;
        // Play the video when it's at least 50% visible
        if (visiblePercentage > 50) {
          if (!_isPlaying) {
            _controller.play();
            setState(() {
              _isPlaying = true;
            });
          }
        } else {
          if (_isPlaying) {
            _controller.pause();
            setState(() {
              _isPlaying = false;
            });
          }
        }
      },
      child: _isInitialized
          ? GestureDetector(
        onTap: () {
          setState(() {
            if (_isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
            _isPlaying = !_isPlaying;
          });
        },
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      )
          : SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
