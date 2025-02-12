import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:instagram_clone/models/user.dart';

class ChatScreenEvent {}

class FetchUsersEvent extends ChatScreenEvent {}

class SearchUsersEvent extends ChatScreenEvent {
  final String query;

  SearchUsersEvent(this.query);
}

class FetchMoreMessagesEvent extends ChatScreenEvent {}

class ChatScreenState {
  final List<User> users;
  final List<User> filteredUsers;
  final List<User> messages;
  final bool isLoading;

  ChatScreenState({
    required this.users,
    required this.filteredUsers,
    required this.messages,
    required this.isLoading,
  });
}

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  final Dio _dio;
  int page = 1;
  static const int pageSize = 2;

  ChatScreenBloc(this._dio)
      : super(ChatScreenState(users: [], filteredUsers: [], messages: [], isLoading: false)) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<SearchUsersEvent>(_onSearchUsers);
    on<FetchMoreMessagesEvent>(_onFetchMoreMessages);
  }

  Future<void> _onFetchUsers(FetchUsersEvent event, Emitter<ChatScreenState> emit) async {
    try {
      Response response = await _dio.get('https://crudcrud.com/api/dc250628451743d69196167a5f5c0608/users');
      List<dynamic> usersData = response.data[0]['users'];
      List<User> users = usersData.map((userJson) => User.fromJson(userJson)).toList();
      emit(ChatScreenState(users: users, filteredUsers: users, messages: [], isLoading: false));
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  void _onSearchUsers(SearchUsersEvent event, Emitter<ChatScreenState> emit) {
    String query = event.query.toLowerCase();
    final filteredUsers = state.users.where((user) {
      return user.username.toLowerCase().contains(query);
    }).toList();
    emit(ChatScreenState(
      users: state.users,
      filteredUsers: filteredUsers,
      messages: state.messages,
      isLoading: false,
    ));
  }

  Future<void> _onFetchMoreMessages(FetchMoreMessagesEvent event, Emitter<ChatScreenState> emit) async {
    if (state.isLoading) return;

    try {
      emit(ChatScreenState(
        users: state.users,
        filteredUsers: state.filteredUsers,
        messages: state.messages,
        isLoading: true,
      ));

      Response response = await _dio.get('https://crudcrud.com/api/dc250628451743d69196167a5f5c0608/users',
          queryParameters: {'page': page, 'size': pageSize});

      List<dynamic> messagesData = response.data[0]['messages'];
      List<User> newMessages = messagesData.map((messageJson) => User.fromJson(messageJson)).toList();

      emit(ChatScreenState(
        users: state.users,
        filteredUsers: state.filteredUsers,
        messages: [...state.messages, ...newMessages],
        isLoading: false,
      ));

      page++;
    } catch (e) {
      emit(ChatScreenState(
        users: state.users,
        filteredUsers: state.filteredUsers,
        messages: state.messages,
        isLoading: false,
      ));
    }
  }
}
