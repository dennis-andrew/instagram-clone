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

  ChatScreenState({required this.users, required this.filteredUsers});
}

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  final Dio _dio;

  ChatScreenBloc(this._dio) : super(ChatScreenState(users: [], filteredUsers: [])) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<SearchUsersEvent>(_onSearchUsers);
  }

  Future<void> _onFetchUsers(FetchUsersEvent event, Emitter<ChatScreenState> emit) async {
    try {
      Response response = await _dio.get('https://crudcrud.com/api/855e8bffc57942c1b8f72cd228c5440b/users');
      List<dynamic> usersData = response.data[0]['users'];
      List<User> users = usersData.map((userJson) => User.fromJson(userJson)).toList();
      emit(ChatScreenState(users: users, filteredUsers: users));
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  void _onSearchUsers(SearchUsersEvent event, Emitter<ChatScreenState> emit) {
    String query = event.query.toLowerCase();
    final filteredUsers = state.users.where((user) {
      return user.username.toLowerCase().contains(query);
    }).toList();
    emit(ChatScreenState(users: state.users, filteredUsers: filteredUsers));
  }
}
