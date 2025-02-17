import '../../models/user.dart';

class ChatScreenState {
  final List<User> users;
  final List<User> filteredUsers;
  final bool isLoading;
  final String error;
  final bool isLoadingMore;

  ChatScreenState({
    this.users = const [],
    this.filteredUsers = const [],
    this.isLoading = true,
    this.isLoadingMore = false,
    this.error = '',
  });

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