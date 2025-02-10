import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/bloc/chat_screen_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatScreenBloc(Dio())..add(FetchUsersEvent()),
      child: Scaffold(
        appBar: AppBar(
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
      padding: EdgeInsets.all(8.0.w),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
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
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: SizedBox(
        height: 100.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundImage: NetworkImage(filteredUsers[index].photoUrl),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    filteredUsers[index].username,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black87),
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
      padding: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 0),
      child: Column(
        children: [
          Row(
            children: [
              Text("Messages", style: TextStyle(fontSize: 20.sp)),
              Spacer(),
              Text(
                "Requests",
                style: TextStyle(color: Colors.blueAccent, fontSize: 20.sp),
              ),
            ],
          ),
          LazyLoadScrollView(
            onEndOfPage: () {
              context.read<ChatScreenBloc>().add(FetchMoreMessagesEvent());
            },
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 10.h),
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
                          size: 30.sp,
                        ),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(height: 10.h),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
