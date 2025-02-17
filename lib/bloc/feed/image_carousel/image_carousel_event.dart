class ImageCarouselEvent {}

class LoadCarouselEvent extends ImageCarouselEvent {
  final List<String> carouselImages;

  LoadCarouselEvent({required this.carouselImages});
}

class ChangeIndexEvent extends ImageCarouselEvent {
  final int index;

  ChangeIndexEvent({required this.index});
}