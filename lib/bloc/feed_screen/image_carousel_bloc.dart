import 'package:flutter_bloc/flutter_bloc.dart';

class ImageCarouselEvent {}

class LoadCarouselEvent extends ImageCarouselEvent {
  final List<String> carouselImages;

  LoadCarouselEvent({required this.carouselImages});
}

class ChangeIndexEvent extends ImageCarouselEvent {
  final int index;

  ChangeIndexEvent({required this.index});
}

class ImageCarouselState {
  final List<String> carouselImages;
  final int currentIndex;

  ImageCarouselState({required this.carouselImages, required this.currentIndex});
}

class ImageCarouselBloc extends Bloc<ImageCarouselEvent, ImageCarouselState> {
  ImageCarouselBloc() : super(ImageCarouselState(carouselImages: [], currentIndex: 0)) {
    on<LoadCarouselEvent>(_onLoadCarousel);
    on<ChangeIndexEvent>(_onChangeIndex);
  }

  void _onLoadCarousel(LoadCarouselEvent event, Emitter<ImageCarouselState> emit) {
    emit(ImageCarouselState(carouselImages: event.carouselImages, currentIndex: 0));
  }

  void _onChangeIndex(ChangeIndexEvent event, Emitter<ImageCarouselState> emit) {
    emit(ImageCarouselState(carouselImages: state.carouselImages, currentIndex: event.index));
  }
}
