import 'package:flutter/material.dart';
import 'package:veli_flutter/utils/app_color.dart';

class ZoomImagePage extends StatefulWidget {
  final String imageUrl;

  ZoomImagePage({required this.imageUrl});

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ZoomImagePage> {
  bool isZoomed = false;
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            isZoomed = !isZoomed;
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: InteractiveViewer(
                minScale: 1.0,
                maxScale: 2.0,
                scaleEnabled: isZoomed,
                onInteractionUpdate: (details) {
                  setState(() {
                    scale = details.scale;
                  });
                },
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: isZoomed ? MediaQuery.of(context).size.height * 0.13 : 0,
              left: isZoomed ? MediaQuery.of(context).size.width * 0.13 : 0,
              right: isZoomed ? MediaQuery.of(context).size.width * 0.13 : 0,
              bottom: isZoomed ? MediaQuery.of(context).size.height * 0.13 : 0,
              child: isZoomed
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isZoomed = false;
                          scale = 1.0;
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
