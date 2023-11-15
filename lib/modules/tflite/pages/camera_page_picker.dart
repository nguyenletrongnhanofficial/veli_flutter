import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../widgets/image_classification.dart';

class CameraPagePicker extends StatefulWidget {
  final CameraDescription camera;

  const CameraPagePicker({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraPagePickerState createState() => _CameraPagePickerState();
}

class _CameraPagePickerState extends State<CameraPagePicker>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  ImageClassification? _imageClassification;
  Map<String, double>? _classification;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _setupCamera();
    _setupImageClassification();
    WidgetsBinding.instance.addObserver(this);
  }

  void _setupCamera() {
    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      imageFormatGroup:
          Platform.isIOS ? ImageFormatGroup.bgra8888 : ImageFormatGroup.yuv420,
    );
    _cameraController?.initialize().then((_) {
      if (!mounted) return;
      _cameraController?.startImageStream(_onImageAvailable);
      setState(() {});
    });
  }

  void _setupImageClassification() {
    _imageClassification = ImageClassification()..initHelper();
  }

  Future<void> _onImageAvailable(CameraImage image) async {
    if (_isProcessing) return;
    _isProcessing = true;
    _classification = await _imageClassification?.inferenceCameraFrame(image);
    _isProcessing = false;
    if (mounted) setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;
    if (state == AppLifecycleState.paused) {
      _cameraController?.stopImageStream();
    } else if (state == AppLifecycleState.resumed &&
        !_cameraController!.value.isStreamingImages) {
      await _cameraController?.startImageStream(_onImageAvailable);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    _imageClassification?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          _buildCameraPreview(),
          _buildClassificationDisplay(),
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const SizedBox.shrink();
    }
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * _cameraController!.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;
    return Transform.scale(
      scale: scale,
      child: CameraPreview(_cameraController!),
    );
  }

  Widget _buildClassificationEntry(MapEntry<String, double> entry) {
    if (entry.key != '0 document') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                  size: 25,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    "Hình ảnh của bạn có thể không được phép đăng",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 100),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "Hình ảnh của bạn thuộc loại",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            entry.key,
            style: const TextStyle(
                fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          Text(
            "Độ chính xác: ${entry.value.toStringAsFixed(2)}",
            style: const TextStyle(
                fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildClassificationDisplay() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: _classification == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Column(
                children: _classification!.entries.map((entry) {
                  return _buildClassificationEntry(entry);
                }).toList(),
              ),
            ),
    );
  }
}
