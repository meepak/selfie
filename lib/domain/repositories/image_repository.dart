import 'package:dartz/dartz.dart';
import 'package:selfie/core/error/failures.dart';
import 'package:selfie/data/models/image_model.dart';
import 'package:selfie/domain/entities/selfie_image.dart';

abstract class ImageRepository {
  Future<Either<Failure, List<ImageEntity>>> getSavedImages();
  Future<Either<Failure, ImageEntity>> saveImage(ImageModel imageToSave);
}