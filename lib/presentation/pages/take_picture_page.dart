import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:selfie/presentation/bloc/image_bloc.dart';
import 'package:selfie/presentation/bloc/image_event.dart';

class TakePicturePage extends StatefulWidget {
  final ImageBloc bloc;

  TakePicturePage({
    Key key,
    @required this.camera,
    @required this.bloc,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  _TakePicturePageState createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
        widget.camera,
        ResolutionPreset.medium
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take a selfie'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn2",
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final path = join(
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png'
            );
            print(path);

            await _controller.takePicture(path);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DisplayPicturePage(
                      imagePath: path,
                      bloc: widget.bloc
                    )
                )
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}

class DisplayPicturePage extends StatefulWidget {
  final String imagePath;
  final ImageBloc bloc;

  const DisplayPicturePage({
    Key key,
    @required this.imagePath,
    @required this.bloc
  }) : super(key: key);

  @override
  _DisplayPicturePageState createState() => _DisplayPicturePageState(
    imagePath: imagePath
  );
}

class _DisplayPicturePageState extends State<DisplayPicturePage> {
  final String imagePath;

  _DisplayPicturePageState({@required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selfie Preview'),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Image.file(File(widget.imagePath)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () async {
                        widget.bloc.add(SaveImage(imagePath: imagePath));
                    Navigator.pushNamed(context, '/');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.save),
                      Text("Save"),
                    ],
                  ),
                ),RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: Colors.grey,
                  onPressed: ()  {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.delete_forever),
                      Text("Delete"),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

