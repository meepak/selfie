import 'package:dartz/dartz.dart';
import 'package:selfie/core/error/failures.dart';
import 'package:selfie/domain/entities/selfie_image.dart';
import 'package:selfie/domain/repositories/image_repository.dart';

class GetSavedImagesUseCase {
  final ImageRepository repository;

  GetSavedImagesUseCase(this.repository);

  Future<Either<Failure, List<ImageEntity>>> call() async {
    final images = await repository.getSavedImages();
    return images;
  }

}
