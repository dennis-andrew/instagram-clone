import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/bloc/chat_screen_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatScreenBloc(Dio())..add(FetchUsersEvent()),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leadingWidth: MediaQuery.of(context).size.width * 0.15,
          title: Text("_my_profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.note_alt_outlined, size: 24.sp)),
          ],
        ),
        body: Column(
          children: [
            SearchField(),
            UserList(),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.0.w,14.0.w,8.0.w,0.w),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Ask Meta AI or search',
          prefixIcon: Icon(Icons.search, size: 24.sp),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (query) {
          context.read<ChatScreenBloc>().add(SearchUsersEvent(query));
        },
      ),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatScreenBloc, ChatScreenState>(
      builder: (context, state) {
        if (state.isLoading || state.users.isEmpty) {
          return Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        }
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                UserCarousel(filteredUsers: state.filteredUsers),
                MessagesList(filteredUsers: state.filteredUsers),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserCarousel extends StatelessWidget {
  final List<User> filteredUsers;

  const UserCarousel({super.key, required this.filteredUsers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.0.w,16.0.h,4.0.w,4.0.h),
      child: SizedBox(
        height: 100.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.fromLTRB(12.0.w,16.0.h,12.0.w,0.h),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: NetworkImage(filteredUsers[index].photoUrl),
                      ),
                      if (index < 3)
                        Positioned(
                            top: -20.h,
                            left: -5.w,
                            child: Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(10.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                                constraints: BoxConstraints(maxWidth: 70.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  index == 0
                                      ? "Share a note"
                                      : "I am ${filteredUsers[index].username}",
                                  style: TextStyle(fontSize: 10.sp, color: index==0?Colors.black54:Colors.black),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            )
                        ),
                      if(index>=3)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: null,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    index==0? "Your note":
                    filteredUsers[index].username,
                    style: TextStyle(fontSize: 12.sp, color: index==0?Colors.black54:Colors.black),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MessagesList extends StatelessWidget {
  final List<User> filteredUsers;

  const MessagesList({super.key, required this.filteredUsers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6.w, 15.h, 6.w, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Text("Messages", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Spacer(),
                Text(
                  "Requests",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(height: 4.h),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25.r,
                      backgroundImage: NetworkImage(filteredUsers[index].photoUrl),
                    ),
                    title: Text(filteredUsers[index].username),
                    subtitle: Text("Hey, how's it going?"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 28.sp,
                        color: Colors.black38,
                      ),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(height: 10.h),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
