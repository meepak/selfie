import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:selfie/domain/entities/selfie_image.dart';

@immutable
abstract class ImageState extends Equatable {
  @override
  List<Object> get props => [];

}

class Empty extends ImageState {}
class Loading extends ImageState {}
class Loaded extends ImageState {
  final List<ImageEntity> imageList;

  Loaded({
  @required this.imageList
  });

  @override
  List<Object> get props => [imageList];
}
class Saved extends ImageState {
  final ImageEntity image;

  Saved({
  @required this.image
  });

  @override
  List<Object> get props => [image];
}
class Error extends ImageState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}