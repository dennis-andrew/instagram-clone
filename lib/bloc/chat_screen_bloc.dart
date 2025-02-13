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
  final bool isEmptyAfterFetch;

  ChatScreenState({
    this.users = const [],
    this.filteredUsers = const [],
    this.isLoading = true,
    this.isLoadingMore = false,
    this.isEmptyAfterFetch = false,
    this.error = '',
  });

  ChatScreenState copyWith({
    List<User>? users,
    List<User>? filteredUsers,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isEmptyAfterFetch,
    String? error,
  }) {
    return ChatScreenState(
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isEmptyAfterFetch: isEmptyAfterFetch ?? this.isEmptyAfterFetch,
      error: error ?? this.error,
    );
  }
}

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  final Dio _dio;
  final ScrollController scrollController = ScrollController();

  ChatScreenBloc(this._dio) : super(ChatScreenState()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<SearchUsersEvent>(_onSearchUsers);

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        add(FetchUsersEvent());
      }
    });
  }

  Future<void> _onFetchUsers(FetchUsersEvent event, Emitter<ChatScreenState> emit) async {
    try {
      if (state.users.isEmpty) {
        //first load
        emit(state.copyWith(isLoading: true,isLoadingMore: false));
      } else {
        //pagination
        emit(state.copyWith(isLoading: false,isLoadingMore: true));
      }

      Response response = await _dio.get('https://crudcrud.com/api/68a5e9c9c2784510988e9b16bc0d9d8c/messages');
      List<dynamic> usersData = response.data[0]['users'];
      List<User> newUsers = usersData.map((userJson) => User.fromJson(userJson)).toList();

      if (newUsers.isEmpty) {
        emit(state.copyWith(isLoading: false, isEmptyAfterFetch: true));
      } else {
        emit(state.copyWith(
          users: [...state.users, ...newUsers],
          filteredUsers: [...state.filteredUsers, ...newUsers],
          isLoading: false,
          isLoadingMore: false,
          isEmptyAfterFetch: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, isLoadingMore: false, error: "Error fetching users: $e"));
    }
  }

  void _onSearchUsers(SearchUsersEvent event, Emitter<ChatScreenState> emit) {
    final query = event.query.toLowerCase();
    final filteredUsers = state.users.where((user) => user.username.toLowerCase().contains(query)).toList();

    emit(state.copyWith(filteredUsers: filteredUsers));
  }
}
