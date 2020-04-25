import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:selfie/presentation/bloc/image_bloc.dart';
import 'package:selfie/presentation/pages/take_picture_page.dart';

class TakePicture extends StatelessWidget {
  final CameraDescription camera;
  final ImageBloc bloc;

  const TakePicture({
    Key key,
    @required this.camera,
    @required this.bloc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
//      height: MediaQuery.of(context).size.height * 0.7,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff3CA0FE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)
              )
            ),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 320),
            child: Center(
                child: Text(
                  'I am a Selfitis.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18
                  ),
                )
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            height: MediaQuery.of(context).size.height * 0.6 * 0.78,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xff9FD0FF),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                )
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6 * 0.7,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/landing_image.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.56
            ),
            child: FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TakePicturePage(
                          camera: camera,
                          bloc: bloc
                        )
                    )
                );
              },
              child: Icon(Icons.camera_enhance),
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
