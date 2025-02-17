class ChatScreenEvent {}

class FetchUsersEvent extends ChatScreenEvent {}

class SearchUsersEvent extends ChatScreenEvent {
  final String query;
  SearchUsersEvent(this.query);
}