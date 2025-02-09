import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'chat_screen.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/models/post.dart'; // Import your Post model

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Dio _dio;
  List<User> users = [];
  List<Post> posts = []; // To hold the fetched posts

  @override
  void initState() {
    super.initState();
    _dio = Dio();
    _fetchUsers();
    _fetchPosts(); // Fetch posts on screen initialization
  }

  Future<void> _fetchUsers() async {
    try {
      Response response = await _dio.get('https://crudcrud.com/api/83de555d7762468692cd5890975edd16/users');
      List<dynamic> usersData = response.data[0]['users'];
      setState(() {
        users = usersData.map((userJson) => User.fromJson(userJson)).toList();
      });
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  Future<void> _fetchPosts() async {
    try {
      Response response = await _dio.get('https://crudcrud.com/api/83de555d7762468692cd5890975edd16/posts');
      List<dynamic> postsData = response.data[0]['posts'];
      setState(() {
        posts = postsData.map((postJson) => Post.fromJson(postJson)).toList();
      });
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/insta_logo.png", height: 60),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
          SizedBox(width: 5),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
            },
            icon: ImageIcon(AssetImage("assets/images/messenger.png"), size: 32),
          ),
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
                  users.length,
                      (index) {
                    User user = users[index];
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage("assets/images/insta_story.png"),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(user.photoUrl),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            user.username,
                            style: TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Divider(),

            // Posts Section (Dynamic Posts)
            Column(
              children: List.generate(
                posts.length, // Dynamically generate posts
                    (index) {
                  Post post = posts[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundImage: AssetImage("assets/images/insta_story.png"),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(users[index].photoUrl),
                            ),
                          ),
                        ),
                        Text(users[index].username),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {},
                        )
                      ]),
                      post.type == "image" // Image post
                          ? Image.network(post.mediaUrl)
                          : post.type == "carousel" // Carousel post
                          ? ImageCarousel(carouselImages: post.carouselImages)
                          : post.type == "video" // Video post
                          ? VideoPost(videoUrl: post.mediaUrl)
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
                                          text: ' ${users[index+1].username}',
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
                                        text: " ${users[index].username} ",
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text:
                                          post.caption),
                                    ])),
                            SizedBox(height: 10),
                            Text("13 hours ago",
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
      bottomNavigationBar: CupertinoTabBar(height: 80, activeColor: Colors.black, items: [
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
            icon: ImageIcon(AssetImage("assets/images/video.png"), color: Colors.black, size: 26,),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, color: Colors.black),
            label: '')
      ]),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  final List<String> carouselImages;

  ImageCarousel({required this.carouselImages});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('carousel-visibility'),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;
        // You can trigger any behavior based on visibility
        print('Carousel visible: $visiblePercentage%');
      },
      child: Stack(
        children: [
          CarouselSlider(
            items: widget.carouselImages
                .map((imageUrl) => Image.network(imageUrl))
                .toList(),
            options: CarouselOptions(
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
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
                '${_currentIndex + 1}/${widget.carouselImages.length}',
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
                widget.carouselImages.length,
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
      ),
    );
  }
}

class VideoPost extends StatefulWidget {
  final String videoUrl;

  VideoPost({required this.videoUrl});

  @override
  _VideoPostState createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  bool _isVisible = false; // To track the visibility state

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true); // Optional: loop the video
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Don't forget to dispose the controller
  }

  void _onVisibilityChanged(VisibilityInfo visibilityInfo) {
    double visibleFraction = visibilityInfo.visibleFraction;
    if (visibleFraction > 0.5 && !_controller.value.isPlaying) {
      // Play video when at least 50% is visible
      _controller.play();
      setState(() {
        _isVisible = true;
      });
    } else if (visibleFraction <= 0.5 && _controller.value.isPlaying) {
      // Pause video when less than 50% is visible
      _controller.pause();
      setState(() {
        _isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('video-visibility-${widget.videoUrl}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: FutureBuilder<void>(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the video is initialized, show the VideoPlayer widget
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            // While the video is initializing, show a loading spinner
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}