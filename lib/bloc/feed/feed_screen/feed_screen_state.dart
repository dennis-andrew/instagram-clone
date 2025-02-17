import '../../../models/post.dart';
import '../../../models/user.dart';

class FeedScreenState {
  final List<User> users;
  final List<Post> posts;
  final String errorMessage;
  final bool isLoading;

  FeedScreenState({required this.users, required this.posts, this.errorMessage = '', this.isLoading = false});
}