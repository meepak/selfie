import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:selfie/presentation/pages/landing_page.dart';
import 'injection_container.dart' as di;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  // initialized camera service plugin
  WidgetsFlutterBinding.ensureInitialized();

  // get list of available cameras on the device
  final cameras = await availableCameras();

  // get front camera
  final firstCamera = cameras[1];

  runApp(
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
//        home: LandingPage(camera: firstCamera),
        initialRoute: '/',
        routes: {
          '/': (context) => LandingPage(camera: firstCamera),
        },
      )
  );
}



