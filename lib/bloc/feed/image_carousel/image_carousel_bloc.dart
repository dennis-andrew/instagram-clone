import 'package:flutter_bloc/flutter_bloc.dart';

import 'image_carousel_event.dart';
import 'image_carousel_state.dart';

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
