import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ImageEvent extends Equatable {}


class GetSavedImages extends ImageEvent {

  @override
  List<Object> get props => [];

}

class SaveImage extends ImageEvent {
  final String imagePath;

  SaveImage({
    @required this.imagePath
  });

  @override
  List<Object> get props => [imagePath];

}