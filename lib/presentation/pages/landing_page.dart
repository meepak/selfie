import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selfie/presentation/bloc/image_bloc.dart';
import 'package:selfie/presentation/bloc/image_event.dart';
import 'package:selfie/presentation/widgets/list_pictures.dart';
import 'package:selfie/presentation/widgets/take_picture.dart';

import '../../injection_container.dart';

class LandingPage extends StatefulWidget {
  final CameraDescription camera;

  const LandingPage({
    Key key,
    @required this.camera
  }) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  ImageBloc _imageBloc;

  @override
  void initState() {
    super.initState();
    _imageBloc = sl<ImageBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: _onBackPressed,
      child: BlocProvider(
          child:  Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Container(
              color: Colors.white,
              child: Scaffold(
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      TakePicture(
                        camera: widget.camera,
                        bloc: _imageBloc
                      ),
                      ListPictures(),
                    ],
                  ),
                ),
              )
            ),
          ), create: (BuildContext context) => _imageBloc,
      ),
    );
  }

  Future<bool> _onBackPressed(){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you really want to exit the app?'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () => SystemNavigator.pop()
          )
        ],
      )
    );
  }
}
