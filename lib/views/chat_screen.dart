import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/bloc/chat_screen_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatScreenBloc(Dio())..add(FetchUsersEvent()),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 60,
          title: Text("_my_profile", style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.note_alt_outlined)),
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

  SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Ask Meta AI or search',
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
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

  const UserCarousel({Key? key, required this.filteredUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(filteredUsers[index].photoUrl),
                  ),
                  SizedBox(height: 5),
                  Text(
                    filteredUsers[index].username,
                    style: TextStyle(fontSize: 12, color: Colors.black87),
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

  const MessagesList({Key? key, required this.filteredUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(
        children: [
          Row(
            children: [
              Text("Messages", style: TextStyle(fontSize: 20)),
              Spacer(),
              Text(
                "Requests",
                style: TextStyle(color: Colors.blueAccent, fontSize: 20),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(height: 10),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(filteredUsers[index].photoUrl),
                    ),
                    title: Text(filteredUsers[index].username),
                    subtitle: Text("Hey, how's it going?"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 30,
                      ),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

