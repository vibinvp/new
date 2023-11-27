import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      required this.cityController,
      required this.stateController,
      required this.pinCodeController,
      required this.addressController,
      required this.latitudeController,
      required this.longitudeController});

  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController pinCodeController;
  final TextEditingController addressController;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool fromRegistration = false;
  LatLng? latlong;
  late CameraPosition _cameraPosition;
  GoogleMapController? _controller;
  TextEditingController locationController = TextEditingController();
  final Set<Marker> _markers = {};

  Future getCurrentLocation() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      await Geolocator.requestPermission();
    } else {
      Geolocator.getCurrentPosition().then((value) async {
        List<Placemark> placemark =
            await placemarkFromCoordinates(value.latitude, value.longitude);

        if (mounted) {
          setState(
            () {
              latlong = LatLng(value.latitude, value.longitude);

              _cameraPosition = CameraPosition(target: latlong!, zoom: 16.0);
              if (_controller != null) {
                _controller!.animateCamera(
                    CameraUpdate.newCameraPosition(_cameraPosition));
              }

              // ignore: prefer_typing_uninitialized_variables
              var address;
              address = placemark[0].name;
              address = address + ',' + placemark[0].subLocality;
              address = address + ',' + placemark[0].locality;
              address = address + ',' + placemark[0].administrativeArea;
              address = address + ',' + placemark[0].country;
              address = address + ',' + placemark[0].postalCode;

              locationController.text = address;
              widget.cityController.text = placemark[0].locality ?? '';
              widget.pinCodeController.text = placemark[0].postalCode ?? '';
              widget.stateController.text =
                  placemark[0].administrativeArea ?? '';
              widget.latitudeController.text = value.latitude.toString();
              widget.longitudeController.text = value.longitude.toString();

              print(
                  'latitude-------------->>  ${widget.latitudeController.text}<<<----------------->>>${widget.longitudeController.text}');
              _markers.add(
                Marker(
                  markerId: const MarkerId('Marker'),
                  position: LatLng(value.latitude, value.longitude),
                ),
              );
            },
          );
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _cameraPosition = const CameraPosition(target: LatLng(0, 0), zoom: 10.0);
    getCurrentLocation();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColoring.kAppWhiteColor),
        backgroundColor: AppColoring.kAppColor,
        title: const Text(
          'Choose Location',
          style: TextStyle(color: AppColoring.kAppWhiteColor),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  (latlong != null)
                      ? GoogleMap(
                          initialCameraPosition: _cameraPosition,
                          onMapCreated: (GoogleMapController controller) {
                            _controller = (controller);
                            _controller!.animateCamera(
                              CameraUpdate.newCameraPosition(
                                _cameraPosition,
                              ),
                            );
                          },
                          minMaxZoomPreference:
                              const MinMaxZoomPreference(0, 16),
                          markers: myMarker(),
                          onTap: (latLng) {
                            if (mounted) {
                              setState(
                                () {
                                  latlong = latLng;
                                },
                              );
                            }
                          },
                        )
                      : Container(),
                ],
              ),
            ),
            TextField(
              cursorColor: AppColoring.textDark,
              controller: locationController,
              readOnly: true,
              style: const TextStyle(
                color: AppColoring.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                icon: Container(
                  margin: const EdgeInsetsDirectional.only(
                    start: 20,
                    top: 0,
                  ),
                  width: 10,
                  height: 10,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                ),
                hintText: 'pick up',
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsetsDirectional.only(start: 15.0, top: 12.0),
              ),
            ),
            ElevatedButton(
              child: const Text(
                "Save Location",
              ),
              onPressed: () {
                // profileProvider!.latitutute = latlong!.latitude.toString();
                // profileProvider!.longitude = latlong!.longitude.toString();
                Navigator.pop(context);
              },
            ),
            AppSpacing.ksizedBox20,
          ],
        ),
      ),
    );
  }

  Set<Marker> myMarker() {
    _markers.clear();

    _markers.add(
      Marker(
        markerId: MarkerId(Random().nextInt(10000).toString()),
        position: LatLng(latlong!.latitude, latlong!.longitude),
      ),
    );

    getLocation();

    return _markers;
  }

  Future<void> getLocation() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latlong!.latitude, latlong!.longitude);

    // ignore: prefer_typing_uninitialized_variables
    var address;
    address = placemark[0].name;
    address = address + ',' + placemark[0].subLocality;
    address = address + ',' + placemark[0].locality;
    address = address + ',' + placemark[0].administrativeArea;
    address = address + ',' + placemark[0].country;
    address = address + ',' + placemark[0].postalCode;
    locationController.text = address;
    widget.cityController.text = placemark[0].locality ?? '';
    widget.pinCodeController.text = placemark[0].postalCode ?? '';
    widget.stateController.text = placemark[0].administrativeArea ?? '';
    widget.addressController.text = address ?? '';

    widget.latitudeController.text = latlong!.latitude.toString();
    widget.longitudeController.text = latlong!.longitude.toString();

    print(
        'latitude-------------->> markar  ${widget.latitudeController.text}<<<----------------->>>${widget.longitudeController.text}');
    if (mounted) {
      setState(
        () {},
      );
    }
  }
}
