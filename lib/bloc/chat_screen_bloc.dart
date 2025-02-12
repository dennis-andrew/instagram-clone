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

  ChatScreenState({
    required this.users,
    required this.filteredUsers,
    required this.isLoading,
    this.error = '',
  });

  factory ChatScreenState.initial() {
    return ChatScreenState(
      users: [],
      filteredUsers: [],
      isLoading: false,
      error: '',
    );
  }

  ChatScreenState copyWith({
    List<User>? users,
    List<User>? filteredUsers,
    bool? isLoading,
    String? error,
  }) {
    return ChatScreenState(
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  final Dio _dio;

  ChatScreenBloc(this._dio) : super(ChatScreenState.initial()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<SearchUsersEvent>(_onSearchUsers);
  }

  Future<void> _onFetchUsers(FetchUsersEvent event, Emitter<ChatScreenState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      Response response = await _dio.get('https://crudcrud.com/api/dc250628451743d69196167a5f5c0608/users');
      List<dynamic> usersData = response.data[0]['users'];
      List<User> users = usersData.map((userJson) => User.fromJson(userJson)).toList();

      emit(state.copyWith(
        users: users,
        filteredUsers: users,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
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
