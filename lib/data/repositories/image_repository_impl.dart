import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:selfie/core/error/failures.dart';
import 'package:selfie/core/error/exceptions.dart';
import 'package:selfie/data/datasources/image_local_data_source.dart';
import 'package:selfie/data/models/image_model.dart';
import 'package:selfie/domain/entities/selfie_image.dart';
import 'package:selfie/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageLocalDataSource localDataSource;

  ImageRepositoryImpl({
    @required this.localDataSource
  });
  @override
  Future<Either<Failure, List<ImageEntity>>> getSavedImages() async {
    try {
      final images = await localDataSource.getSavedImages();
      return Right(images);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, ImageEntity>> saveImage(ImageModel imageToSave) async {
    try {
      final image = await localDataSource.saveImage(imageToSave);
      return Right(image);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

}