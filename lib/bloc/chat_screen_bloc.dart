import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:instagram_clone/models/user.dart';

class ChatScreenEvent {}

class FetchUsersEvent extends ChatScreenEvent {}

class SearchUsersEvent extends ChatScreenEvent {
  final String query;

  SearchUsersEvent(this.query);
}

class ChatScreenState {
  final List<User> users;
  final List<User> filteredUsers;
  final bool isLoading;
  final String error;
  final bool isLoadingMore;

  ChatScreenState({
    required this.users,
    required this.filteredUsers,
    required this.isLoading,
    required this.isLoadingMore,
    this.error = '',
  });

  factory ChatScreenState.initial() {
    return ChatScreenState(
      users: [],
      filteredUsers: [],
      isLoading: false,
      isLoadingMore: false,
      error: '',
    );
  }

  ChatScreenState copyWith({
    List<User>? users,
    List<User>? filteredUsers,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
  }) {
    return ChatScreenState(
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
    );
  }
}

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  final Dio _dio;
  final ScrollController scrollController = ScrollController();

  ChatScreenBloc(this._dio) : super(ChatScreenState.initial()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<SearchUsersEvent>(_onSearchUsers);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        add(FetchUsersEvent());
      }
    });
  }


  Future<void> _onFetchUsers(FetchUsersEvent event, Emitter<ChatScreenState> emit) async {
    if (state.isLoading || state.isLoadingMore) return;

    try {
      emit(state.copyWith(isLoadingMore: true));
      Response response = await _dio.get('https://crudcrud.com/api/bbb59d7bad874596a8e9cd687ad6f8bd/messages');
      List<dynamic> usersData = response.data[0]['users'];
      List<User> newUsers = usersData.map((userJson) => User.fromJson(userJson)).toList();

      emit(state.copyWith(
        users: [...state.users, ...newUsers],
        filteredUsers: [...state.users, ...newUsers],
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        error: "Error fetching users: $e",
      ));
      print("Error fetching users: $e");
    }
  }

  void _onSearchUsers(SearchUsersEvent event, Emitter<ChatScreenState> emit) {
    final query = event.query.toLowerCase();
    final filteredUsers = state.users.where((user) {
      return user.username.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(
      filteredUsers: filteredUsers,
    ));
  }
}
