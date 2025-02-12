import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/models/post.dart';

class FeedScreenEvent {}

class FetchUsersEvent extends FeedScreenEvent {}

class FetchPostsEvent extends FeedScreenEvent {}

class FeedScreenState {
  final List<User> users;
  final List<Post> posts;
  final String errorMessage;

  FeedScreenState({required this.users, required this.posts, this.errorMessage = ''});
}

class FeedScreenBloc extends Bloc<FeedScreenEvent, FeedScreenState> {
  final Dio _dio;

  FeedScreenBloc(this._dio) : super(FeedScreenState(users: [], posts: [])) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<FetchPostsEvent>(_onFetchPosts);
  }

  Future<void> _onFetchUsers(FetchUsersEvent event, Emitter<FeedScreenState> emit) async {
    try {
      Response response = await _dio.get('https://crudcrud.com/api/bbb59d7bad874596a8e9cd687ad6f8bd/users');
      List<dynamic> usersData = response.data[0]['users'];
      List<User> users = usersData.map((userJson) => User.fromJson(userJson)).toList();
      emit(FeedScreenState(users: users, posts: []));
    } catch (e) {
      emit(FeedScreenState(users: [], posts: [], errorMessage: "Error fetching users"));
    }
  }

  Future<void> _onFetchPosts(FetchPostsEvent event, Emitter<FeedScreenState> emit) async {
    try {
      Response response = await _dio.get('https://crudcrud.com/api/bbb59d7bad874596a8e9cd687ad6f8bd/posts');
      List<dynamic> postsData = response.data[0]['posts'];
      List<Post> posts = postsData.map((postJson) => Post.fromJson(postJson)).toList();
      emit(FeedScreenState(users: state.users, posts: posts));
    } catch (e) {
      emit(FeedScreenState(users: state.users, posts: [], errorMessage: "Error fetching posts"));
    }
  }
}
