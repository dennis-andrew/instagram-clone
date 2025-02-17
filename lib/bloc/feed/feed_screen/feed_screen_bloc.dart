import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/models/post.dart';

import 'feed_screen_event.dart';
import 'feed_screen_state.dart';

class FeedScreenBloc extends Bloc<FeedScreenEvent, FeedScreenState> {
  final Dio _dio;

  FeedScreenBloc(this._dio) : super(FeedScreenState(users: [], posts: [])) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<FetchPostsEvent>(_onFetchPosts);
  }

  Future<void> _onFetchUsers(FetchUsersEvent event, Emitter<FeedScreenState> emit) async {
    try {
      Response response = await _dio.get('https://crudcrud.com/api/8df72560677e4876bf360ceab372e04c/users');
      List<dynamic> usersData = response.data[0]['users'];
      List<User> users = usersData.map((userJson) => User.fromJson(userJson)).toList();
      emit(FeedScreenState(users: users, posts: state.posts));
    } catch (e) {
      emit(FeedScreenState(users: [], posts: state.posts, errorMessage: "Error fetching users"));
    }
  }

  Future<void> _onFetchPosts(FetchPostsEvent event, Emitter<FeedScreenState> emit) async {
    emit(FeedScreenState(users: state.users, posts: state.posts, isLoading: true));

    try {
      Response response = await _dio.get('https://crudcrud.com/api/8df72560677e4876bf360ceab372e04c/posts');
      List<dynamic> postsData = response.data[0]['posts'];
      List<Post> posts = postsData.isNotEmpty ? postsData.map((postJson) => Post.fromJson(postJson)).toList() : [];
      emit(FeedScreenState(users: state.users, posts: posts, isLoading: false));
    } catch (e) {
      emit(FeedScreenState(users: state.users, posts: [], isLoading: false, errorMessage: "Error fetching posts"));
    }
  }
}
