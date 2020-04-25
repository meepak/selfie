import 'dart:io';

import 'package:flutter/material.dart';
import 'package:selfie/domain/entities/selfie_image.dart';


class ImagesDisplay extends StatefulWidget {
  final List<ImageEntity> images;

  const ImagesDisplay({
    Key key,
    @required this.images,
  }) : super(key: key);

  @override
  _ImagesDisplayState createState() => _ImagesDisplayState();
}

class _ImagesDisplayState extends State<ImagesDisplay> {
  @override
  Widget build(BuildContext context) {
    print('--------into display-------');
    print(widget.images);
    return CustomScrollView(
      primary: true,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              for (var i=0; i<widget.images.length; i++) ImageCard(
                path: widget.images[i].path,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ImageCard extends StatelessWidget {
  final String path;

  const ImageCard({
    Key key,
    @required this.path
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                    path: path,
                )
            )
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green[500]
          ),
          borderRadius: BorderRadius.circular(20)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
            File(path),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}


class DetailScreen extends StatelessWidget {
  final String path;

  const DetailScreen({
    Key key,
    @required this.path
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display Selfie'),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Image.file(File(path)),
      )
    );
  }
}