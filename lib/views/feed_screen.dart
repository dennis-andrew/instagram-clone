import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/bloc/feed_screen/feed_screen_bloc.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../bloc/feed_screen/image_carousel_bloc.dart';
import '../bloc/feed_screen/video_post_bloc.dart';
import 'chat_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/insta_logo.png", height: 50),
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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => FeedScreenBloc(Dio())..add(FetchUsersEvent())..add(FetchPostsEvent())),
          BlocProvider(create: (context) => ImageCarouselBloc()),
          BlocProvider(create: (context) => VideoPostBloc()),
        ],
        child: BlocBuilder<FeedScreenBloc, FeedScreenState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return Center(child: Text(state.errorMessage));
            }

            if (state.posts.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        state.users.length,
                            (index) {
                          User user = state.users[index];
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
                  Column(
                    children: List.generate(
                      state.posts.length,
                          (index) {
                        Post post = state.posts[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundImage: AssetImage("assets/images/insta_story.png"),
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundImage: NetworkImage(state.users[index].photoUrl),
                                    ),
                                  ),
                                ),
                                Text(state.users[index].username),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () {},
                                )
                              ],
                            ),
                            post.type == "image"
                                ? Image.network(post.mediaUrl)
                                : post.type == "carousel"
                                ? ImageCarousel(carouselImages: post.carouselImages)
                                : post.type == "video"
                                ? VideoPost(videoUrl: post.mediaUrl)
                                : SizedBox(),
                            Row(
                              children: [
                                IconButton(
                                  icon: ImageIcon(AssetImage("assets/images/heart.png"), size: 24,),
                                  onPressed: () {},
                                ),
                                Text(post.likes.toString()),
                                IconButton(
                                  icon: ImageIcon(AssetImage("assets/images/chat.png"), size: 24,),
                                  onPressed: () {},
                                ),
                                Text(post.comments.toString()),
                                IconButton(
                                  icon: ImageIcon(AssetImage("assets/images/send.png"), size: 24),
                                  onPressed: () {},
                                ),
                                Text(post.shares.toString()),
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
                                                text: ' ${state.users[index + 1].username}',
                                                style: TextStyle(fontWeight: FontWeight.bold)),
                                            TextSpan(text: " and"),
                                            TextSpan(
                                                text: ' others',
                                                style: TextStyle(fontWeight: FontWeight.bold)),
                                          ])),
                                  SizedBox(height: 10),
                                  RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                            TextSpan(
                                              text: " ${state.users[index].username} ",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(text: post.caption),
                                          ])),
                                  SizedBox(height: 10),
                                  Text("13 hours ago", style: TextStyle(color: Colors.black38))
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(height: 60, activeColor: Colors.black, items: [
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


class ImageCarousel extends StatelessWidget {
  final List<String> carouselImages;

  ImageCarousel({required this.carouselImages});

  @override
  Widget build(BuildContext context) {
    context.read<ImageCarouselBloc>().add(LoadCarouselEvent(carouselImages: carouselImages));

    return BlocBuilder<ImageCarouselBloc, ImageCarouselState>(
      builder: (context, state) {
        return VisibilityDetector(
          key: Key('carousel-visibility'),
          onVisibilityChanged: (visibilityInfo) {
          },
          child: Stack(
            children: [
              CarouselSlider(
                items: state.carouselImages
                    .map((imageUrl) => Image.network(imageUrl))
                    .toList(),
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    context.read<ImageCarouselBloc>().add(ChangeIndexEvent(index: index));
                  },
                  scrollPhysics: BouncingScrollPhysics(),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${state.currentIndex + 1}/${state.carouselImages.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    state.carouselImages.length,
                        (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: state.currentIndex == index
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class VideoPost extends StatelessWidget {
  final String videoUrl;

  VideoPost({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    context.read<VideoPostBloc>().add(LoadVideoPostEvent(videoUrl: videoUrl));

    return BlocBuilder<VideoPostBloc, VideoPostState>(
      builder: (context, state) {
        late VideoPlayerController controller;
        late Future<void> initializeVideoPlayerFuture;

        controller = VideoPlayerController.network(state.videoUrl);
        initializeVideoPlayerFuture = controller.initialize();
        controller.setLooping(true);

        void onVisibilityChanged(VisibilityInfo visibilityInfo) {
          double visibleFraction = visibilityInfo.visibleFraction;
          if (visibleFraction > 0.5 && !controller.value.isPlaying) {
            controller.play();
          } else if (visibleFraction <= 0.5 && controller.value.isPlaying) {
            controller.pause();
          }
        }

        return VisibilityDetector(
          key: Key('video-visibility-${state.videoUrl}'),
          onVisibilityChanged: onVisibilityChanged,
          child: FutureBuilder<void>(
            future: initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      },
    );
  }
}
