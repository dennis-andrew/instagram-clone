import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/bloc/feed/feed_screen/feed_screen_bloc.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../bloc/feed/feed_screen/feed_screen_event.dart';
import '../bloc/feed/feed_screen/feed_screen_state.dart';
import '../bloc/feed/image_carousel/image_carousel_bloc.dart';
import '../bloc/feed/image_carousel/image_carousel_event.dart';
import '../bloc/feed/image_carousel/image_carousel_state.dart';
import '../bloc/feed/video_post/video_post_bloc.dart';
import '../bloc/feed/video_post/video_post_event.dart';
import '../bloc/feed/video_post/video_post_state.dart';
import 'chat_screen.dart';


class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Image.asset("assets/images/insta_logo.png", height: 50.h),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
          SizedBox(width: 5.w),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatScreen()));
            },
            icon:
            ImageIcon(AssetImage("assets/images/messenger.png"), size: 32.h),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FeedScreenBloc(Dio())
              ..add(FetchUsersEvent())
              ..add(FetchPostsEvent()),
          ),
          BlocProvider(create: (context) => ImageCarouselBloc()),
          BlocProvider(create: (context) => VideoPostBloc()),
        ],
        child: BlocBuilder<FeedScreenBloc, FeedScreenState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return Center(child: Text(state.errorMessage));
            }
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.posts.isEmpty) {
              return Center(child: Text('No Posts available'));
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
                            padding: EdgeInsets.all(10.h),
                            child: Column(
                              children: [
                                if (index == 0)
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      CircleAvatar(
                                        radius: 35.r,
                                        backgroundImage: NetworkImage(user.photoUrl),
                                      ),
                                      Positioned(
                                        bottom: -8,
                                        right: -3,
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 3.w,
                                            ),
                                          ),
                                          child: Text(
                                            '+',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (index != 0)
                                  CircleAvatar(
                                    radius: 35.r,
                                    backgroundImage: AssetImage(
                                        "assets/images/insta_story.png"),
                                    child: CircleAvatar(
                                      radius: 30.r,
                                      backgroundImage: NetworkImage(user.photoUrl),
                                    ),
                                  ),
                                SizedBox(height: 10.h),
                                Text(
                                  user.username,
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.black87),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
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
                                    radius: 14.r,
                                    backgroundImage: AssetImage(
                                        "assets/images/insta_story.png"),
                                    child: CircleAvatar(
                                      radius: 12.r,
                                      backgroundImage: NetworkImage(
                                          state.users[index + 2].photoUrl),
                                    ),
                                  ),
                                ),
                                Text(state.users[index + 2].username),
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
                                ? ImageCarousel(
                                carouselImages: post.carouselImages)
                                : post.type == "video"
                                ? VideoPost(videoUrl: post.mediaUrl)
                                : SizedBox(),
                            Row(
                              children: [
                                IconButton(
                                  icon: ImageIcon(
                                    AssetImage("assets/images/heart.png"),
                                    size: 24.h,
                                  ),
                                  onPressed: () {},
                                ),
                                Text(post.likes.toString()),
                                IconButton(
                                  icon: ImageIcon(
                                    AssetImage("assets/images/chat.png"),
                                    size: 24.h,
                                  ),
                                  onPressed: () {},
                                ),
                                Text(post.comments.toString()),
                                IconButton(
                                  icon: ImageIcon(
                                      AssetImage("assets/images/send.png"),
                                      size: 24.h),
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
                                                text:
                                                ' ${state.users[index + 1].username}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold)),
                                            TextSpan(text: " and"),
                                            TextSpan(
                                                text: ' others',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold)),
                                          ])),
                                  SizedBox(height: 10.h),
                                  RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                            TextSpan(
                                              text:
                                              " ${state.users[index].username} ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(text: post.caption),
                                          ])),
                                  SizedBox(height: 10.h),
                                  Text("13 hours ago",
                                    style: TextStyle(color: Colors.black38, fontSize: 12.sp),)
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
      bottomNavigationBar:
      CupertinoTabBar(height: 60.h, activeColor: Colors.black, items: [
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
            icon: ImageIcon(
              AssetImage("assets/images/video.png"),
              color: Colors.black,
              size: 26.sp,
            ),
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

  const ImageCarousel({super.key, required this.carouselImages});

  @override
  Widget build(BuildContext context) {
    context
        .read<ImageCarouselBloc>()
        .add(LoadCarouselEvent(carouselImages: carouselImages));

    return BlocBuilder<ImageCarouselBloc, ImageCarouselState>(
      builder: (context, state) {
        return Column(
          children: [
            Stack(children: [
              CarouselSlider(
                items: state.carouselImages
                    .map((imageUrl) => SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ))
                    .toList(),
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    context
                        .read<ImageCarouselBloc>()
                        .add(ChangeIndexEvent(index: index));
                  },
                  scrollPhysics: BouncingScrollPhysics(),
                  viewportFraction: 1.0,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '${state.currentIndex + 1}/${state.carouselImages.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                state.carouselImages.length,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.h),
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                    state.currentIndex == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class VideoPost extends StatelessWidget {
  final String videoUrl;

  const VideoPost({super.key, required this.videoUrl});

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
