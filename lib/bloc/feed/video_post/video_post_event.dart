class VideoPostEvent {}

class LoadVideoPostEvent extends VideoPostEvent {
  final String videoUrl;

  LoadVideoPostEvent({required this.videoUrl});
}