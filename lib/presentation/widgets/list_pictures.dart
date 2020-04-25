import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfie/presentation/bloc/image_bloc.dart';
import 'package:selfie/presentation/bloc/image_event.dart';
import 'package:selfie/presentation/bloc/image_state.dart';

import 'images_display.dart';
import 'loading_widget.dart';
import 'message_display.dart';

class ListPictures extends StatefulWidget {
  @override
  _ListPicturesState createState() => _ListPicturesState();
}

class _ListPicturesState extends State<ListPictures> {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ImageBloc>(context)
        .add(GetSavedImages());

    print('---------------------------------');
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.5,
      child: Container(
        color: Colors.white,
        child: BlocBuilder<ImageBloc, ImageState>(
          bloc: BlocProvider.of<ImageBloc>(context),
          builder: (context, state) {
            if (state is Empty) {
              return MessageDisplay(
                message: 'No images found.',
              );
            } else if (state is Loading) {
              return LoadingWidget();
            } else if (state is Loaded) {
              if (state.imageList.length == 0){
                return MessageDisplay(
                  message: 'No images found.',
                );
              }
              return ImagesDisplay(images: state.imageList);
            }
          },
        ),
      ),
    );
  }

//  @override
//  void initState() {
//    BlocProvider.of<ImageBloc>(context)
//        .add(GetSavedImages());
//    super.initState();
//  }
}