import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPostEvent {}

class LoadVideoPostEvent extends VideoPostEvent {
  final String videoUrl;

  LoadVideoPostEvent({required this.videoUrl});
}

class VideoPostState {
  final String videoUrl;

  VideoPostState({required this.videoUrl});
}

class VideoPostBloc extends Bloc<VideoPostEvent, VideoPostState> {
  VideoPostBloc() : super(VideoPostState(videoUrl: '')) {
    on<LoadVideoPostEvent>(_onLoadVideoPost);
  }

  void _onLoadVideoPost(LoadVideoPostEvent event, Emitter<VideoPostState> emit) {
    emit(VideoPostState(videoUrl: event.videoUrl));
  }
}
