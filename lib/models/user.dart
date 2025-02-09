class User {
  final String uid;
  final String photoUrl;
  final String username;

  User({
    required this.uid,
    required this.photoUrl,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'photoUrl': photoUrl,
      'username': username,
    };
  }
}