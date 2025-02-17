import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:instagram_clone/models/user.dart';

import 'chat_screen_event.dart';
import 'chat_screen_state.dart';

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

      Response response = await _dio.get('https://crudcrud.com/api/8df72560677e4876bf360ceab372e04c/messages');
      List<dynamic> usersData = response.data[0]['users'];
      List<User> newUsers = usersData.map((userJson) => User.fromJson(userJson)).toList();

      emit(state.copyWith(
        users: [...state.users, ...newUsers],
        filteredUsers: [...state.filteredUsers, ...newUsers],
        isLoading: false,
        isLoadingMore: false,
      ));
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
