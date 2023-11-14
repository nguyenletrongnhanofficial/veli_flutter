import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera_page_picker.dart';
import 'gallery_page_picker.dart';

class TensorFlowPage extends StatefulWidget {
  const TensorFlowPage({super.key});

  @override
  State<TensorFlowPage> createState() => _TensorFlowPageState();
}

class _TensorFlowPageState extends State<TensorFlowPage> {
  late CameraDescription cameraDescription;
  int _selectedIndex = 0;
  List<Widget>? _widgetOptions;

  bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPages();
    });
  }

  initPages() async {
    _widgetOptions = [const GalleryPagePicker()];

    if (cameraIsAvailable) {
      cameraDescription = (await availableCameras()).first;
      _widgetOptions!.add(CameraPagePicker(camera: cameraDescription));
    }

    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions?.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.image_search_sharp),
            label: 'Chọn ảnh từ thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_sharp),
            label: 'Live từ Camera',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
