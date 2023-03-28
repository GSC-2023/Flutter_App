import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class Camview extends StatefulWidget {
  final CameraLensDirection initialDirection = CameraLensDirection.front;
  @override
  State<Camview> createState() => _CamviewState();
}

class _CamviewState extends State<Camview> {
  CameraController? _controller;
  int _cameraIndex = -1;

  bool _isBusy = false;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: false,
      enableClassification: true,
    ),
  );

  double smileProb = 0;
  int smileCount = 0;
  int smileTarget = 10;

  @override
  void initState() {
    super.initState();
    if (cameras.any(
      (element) =>
          element.lensDirection == widget.initialDirection &&
          element.sensorOrientation == 90,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) =>
            element.lensDirection == widget.initialDirection &&
            element.sensorOrientation == 90),
      );
    } else {
      for (var i = 0; i < cameras.length; i++) {
        if (cameras[i].lensDirection == widget.initialDirection) {
          _cameraIndex = i;
          break;
        }
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: videobody(),
          ),
          Text(smileCount.toString()),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: 300,
            height: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value: smileCount / smileTarget,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
                backgroundColor: Color(0xffD6D6D6),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget videobody() {
    if (_controller?.value.isInitialized == false) {
      return Container();
    }
    return SizedBox(
      height: double.infinity,
      child: Center(
        child: CameraPreview(_controller!),
      ),
    );
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (imageRotation == null) return;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) return;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    processImage(inputImage);
  }

  Future processImage(InputImage inputImage) async {
    if (_isBusy) return null;
    _isBusy = true;
    setState(() {});
    final faces = await _faceDetector.processImage(inputImage);
    _isBusy = false;
    if (faces.isNotEmpty) {
      smileProb = faces[0].smilingProbability!;
      if (smileProb > 0.9) {
        smileCount++;
      }
    }
  }
}
