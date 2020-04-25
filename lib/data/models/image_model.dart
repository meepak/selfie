import 'package:meta/meta.dart';
import 'package:selfie/domain/entities/selfie_image.dart';

class ImageModel extends ImageEntity {
  ImageModel({
    @required String path
  }) : super(path: path);

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
    };
  }
}