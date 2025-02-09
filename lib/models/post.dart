class Post {
  final String id;
  final String type; // "image", "video", "carousel"
  final String mediaUrl;
  final String caption;
  final int likes;
  final int comments; // Number of comments
  final int shares;   // Number of shares
  final List<String> carouselImages; // Only used for carousel posts

  Post({
    required this.id,
    required this.type,
    required this.mediaUrl,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.carouselImages,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      type: json['type'],
      mediaUrl: json['mediaUrl'],
      caption: json['caption'],
      likes: json['likes'],
      comments: json['comments'],
      shares: json['shares'],
      carouselImages: List<String>.from(json['carouselImages'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'mediaUrl': mediaUrl,
      'caption': caption,
      'likes': likes,
      'comments': comments,
      'shares': shares,
      'carouselImages': carouselImages,
    };
  }
}
