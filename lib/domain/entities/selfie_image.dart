import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ImageEntity extends Equatable {
  final String path;

  ImageEntity({
    @required this.path
  });

  @override
  // TODO: implement props
  List<Object> get props => [path];

}