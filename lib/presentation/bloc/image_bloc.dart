import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:selfie/core/error/failures.dart';
import 'package:selfie/domain/entities/selfie_image.dart';
import 'package:selfie/domain/usecases/get_saved_images_usecase.dart';
import 'package:selfie/domain/usecases/save_image_usecase.dart';
import './bloc.dart';

const String LOCAL_FAILURE_MESSAGE = 'Local Failure';


class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final GetSavedImagesUseCase getSavedImagesUseCase;
  final SaveImageUseCase saveImageUseCase;

  ImageBloc({
    @required this.saveImageUseCase,
    @required this.getSavedImagesUseCase
  });

  @override
  ImageState get initialState => Empty();

  @override
  Stream<ImageState> mapEventToState(
    ImageEvent event,
  ) async* {
    if (event is GetSavedImages) {
      yield Loading();
      final failureOrImages = await getSavedImagesUseCase();
      print('----------------geting image--------');
      print(failureOrImages);
      yield* _eitherLoadedOrErrorState(failureOrImages);
    } else if (event is SaveImage) {
      yield Loading();
      final failureOrImage = await saveImageUseCase(Params(image: event.imagePath));
      final failureOrImages = await getSavedImagesUseCase();
      yield* _eitherLoadedOrErrorState(failureOrImages);
    }
  }

  Stream<ImageState> _eitherLoadedOrErrorState(
      Either<Failure, List<ImageEntity>> failureOrImages
      ) async* {
    yield failureOrImages.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (images) => Loaded(imageList: images)
    );
  }

  Stream<ImageState> _eitherSavedOrErrorState(
      Either<Failure, ImageEntity> failureOrImages
      ) async* {
    yield failureOrImages.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (image) => Saved(image: image),

    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case LocalFailure:
        return LOCAL_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
