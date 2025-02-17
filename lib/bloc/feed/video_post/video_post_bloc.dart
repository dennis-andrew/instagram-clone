import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/bloc/feed/video_post/video_post_event.dart';
import 'package:instagram_clone/bloc/feed/video_post/video_post_state.dart';

class VideoPostBloc extends Bloc<VideoPostEvent, VideoPostState> {
  VideoPostBloc() : super(VideoPostState(videoUrl: '')) {
    on<LoadVideoPostEvent>(_onLoadVideoPost);
  }

  void _onLoadVideoPost(LoadVideoPostEvent event, Emitter<VideoPostState> emit) {
    emit(VideoPostState(videoUrl: event.videoUrl));
  }
}
