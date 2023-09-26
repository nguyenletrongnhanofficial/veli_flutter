import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng currentLocation = LatLng(10.796467728786398, 106.6667858219294);

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late GoogleMapController _mapController;
  Map<String, Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              zoom: 16,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
              addMarker('test', currentLocation);
            },
            markers: _markers.values.toSet(),
          ),
        ),
      ),
    );
  }

  void addMarker(String id, LatLng location) {
    // var markerIcon = await BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(),
    //   'assets/images/image_bookshop.jpg',
    // );
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: const InfoWindow(
        title: 'Trường ĐH Tài nguyên và Môi trường TPHCM',
        // snippet: 'mô tả',
      ),
      // icon: markerIcon,
    );
    _markers[id] = marker;
    setState(() {});
  }
}
