import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:selfie/core/error/exceptions.dart';
import 'package:selfie/data/models/image_model.dart';

abstract class ImageLocalDataSource {
  Future<List<ImageModel>> getSavedImages();
  Future<ImageModel> saveImage(ImageModel imageToSave);
}


class ImageLocalDataSourceImpl implements ImageLocalDataSource{
  @override
  Future<List<ImageModel>> getSavedImages() async {
    List<ImageModel> images = new List();
    final dirPath = (await getExternalStorageDirectory()).path;
    final dir = new Directory(dirPath);
    try {
      dir.list(recursive: true, followLinks: false)
          .listen((FileSystemEntity entity) {
        images.add(ImageModel(path: entity.path));
      });
      return images;
    } catch (e) {
      throw LocalException();
    }
  }

  @override
  Future<ImageModel> saveImage(ImageModel imageToSave) async {
    final newPath = join(
        (await getExternalStorageDirectory()).path,
        '${DateTime.now()}.png'
    );
    final tempImage = File(imageToSave.path);
    try {
       await tempImage.rename(newPath);
       return ImageModel(path: newPath);
    } on FileSystemException catch (e) {
      // if rename fails, copy the source file and then delete it
      final newFile = await tempImage.copy(newPath);
      await tempImage.delete();
      return ImageModel(path: newPath);
    } catch (e) {
      throw LocalException();
    }
  }

}