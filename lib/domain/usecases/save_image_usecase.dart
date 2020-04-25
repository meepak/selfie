import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:selfie/core/error/failures.dart';
import 'package:selfie/core/usecase/usecase.dart';
import 'package:selfie/data/models/image_model.dart';
import 'package:selfie/domain/entities/selfie_image.dart';
import 'package:selfie/domain/repositories/image_repository.dart';

class SaveImageUseCase implements UseCase<ImageEntity, Params> {
  final ImageRepository repository;

  SaveImageUseCase(this.repository);

  @override
  Future<Either<Failure, ImageEntity>> call(Params params) async {
    return await repository.saveImage(ImageModel(path: params.image));
  }

}

class Params extends Equatable {
  final String image;

  Params({
    @required this.image
  });
  @override
  List<Object> get props => [];
}