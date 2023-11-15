import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:veli_flutter/modules/tflite/widgets/image_classification.dart';

class GalleryPagePicker extends StatefulWidget {
  const GalleryPagePicker({super.key});

  @override
  _GalleryPagePickerState createState() => _GalleryPagePickerState();
}

class _GalleryPagePickerState extends State<GalleryPagePicker> {
  ImageClassification? imageClassificationHelper;
  final ImagePicker _imagePicker = ImagePicker();
  String? _imagePath;
  img.Image? _image;
  Map<String, double>? _classification;

  @override
  void initState() {
    super.initState();
    _initializeImageClassification();
  }

  void _initializeImageClassification() {
    imageClassificationHelper = ImageClassification()..initHelper();
  }

  Future<void> _pickAndProcessImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _setImageAndClassify(pickedFile.path);
    }
  }

  Future<void> _setImageAndClassify(String path) async {
    setState(() {
      _imagePath = path;
      _image = img.decodeImage(File(path).readAsBytesSync());
      _classification = null;
    });
    _classification = await imageClassificationHelper?.inferenceImage(_image!);
    setState(() {});
  }

  @override
  void dispose() {
    imageClassificationHelper?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            if (_imagePath != null) Image.file(File(_imagePath!)),
            if (_image == null)
              const Text("Bạn chưa chọn bất kỳ hình ảnh nào!"),
            TextButton.icon(
              onPressed: _pickAndProcessImage,
              icon: Image.asset('assets/images/image.gif'),
              label: const Text("Chọn ảnh từ thư viện"),
            ),
            if (_classification != null) _buildClassificationResult(),
          ],
        ),
      ),
    );
  }

  Widget _buildClassificationResult() {
    var sortedEntries = _classification!.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return SingleChildScrollView(
      child: Column(
        children: sortedEntries.take(3).map(_buildClassificationEntry).toList(),
      ),
    );
  }

  Widget _buildClassificationEntry(MapEntry<String, double> entry) {
    if (entry.key != '0 document') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showInvalidImageDialog();
      });
    }
    return Container(
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

  void _showInvalidImageDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Hình ảnh không hợp lệ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Bạn không được phép đăng hình ảnh này.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Huỷ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('Tiếp tục'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
