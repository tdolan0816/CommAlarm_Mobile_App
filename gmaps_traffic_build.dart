// ignore_for_file: library_private_types_in_public_api, prefer_final_fields
import 'dart:async';
import 'package:commalarm_app/traffic_data_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_webservice/directions.dart' as dir;
import 'package:google_maps_controller/google_maps_controller.dart';

import 'package:commalarm_app/traffic_data_model.dart';
import 'package:commalarm_app/database_helper.dart';

void main() {
  runApp(const MaterialApp(
    home: GMapsTrafficBuild(),
  ));
}

class GMapsTrafficBuild extends StatefulWidget {
  const GMapsTrafficBuild({Key? key}) : super(key: key);

  @override
  _GMapsTrafficBuildState createState() =>  _GMapsTrafficBuildState();
}

class _GMapsTrafficBuildState extends State<GMapsTrafficBuild> {
  late GoogleMapController _mapController;
  final Completer<GoogleMapController> completer = Completer();
  final Set<Polyline> _polylines = {};
  final List<LatLng> _polylineCoordinates = [];
  final PolylinePoints _polylinePoints = PolylinePoints();
  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> controller = Completer();
  var durationInTraffic = '';
  

  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController durationInTrafficController = TextEditingController();
  



  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
        if (!completer.isCompleted) {
      completer.complete(controller);}
  }

  void _submitData() {
    String origin = originController.text;
    String destination = destinationController.text;
    _getRouteCoordinates(origin, destination);

    }

  void _getRouteCoordinates(String origin, String destination) async {
    List locations = await locationFromAddress(origin);
    LatLng originLatLng = LatLng(locations[0].latitude, locations[0].longitude);

    locations = await locationFromAddress(destination);
    LatLng destinationLatLng = LatLng(locations[0].latitude, locations[0].longitude);

    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAwI0xRyzLwnpib7MY2N6dVLUpWi9iMxOw',
      PointLatLng(originLatLng.latitude, originLatLng.longitude),
      PointLatLng(destinationLatLng.latitude, destinationLatLng.longitude),
    );

    if (result.points.isNotEmpty) {
      setState(() {
        _polylines.clear();
        _polylineCoordinates.clear();
        result.points.forEach((PointLatLng point) {
          _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });

        Polyline polyline = Polyline(
          polylineId: const PolylineId('route'),
          color: const Color.fromARGB(255, 255, 4, 4),
          points: _polylineCoordinates,
          width: 4,
        );

        _polylines.add(polyline);
      });

      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('Origin'),
            position: originLatLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        );
        _markers.add(
          Marker(
            markerId: const MarkerId('Destination'),
            position: destinationLatLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      });

      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          _polylineCoordinates.first.latitude,
          _polylineCoordinates.first.longitude,
        ),
        northeast: LatLng(
          _polylineCoordinates.last.latitude,
          _polylineCoordinates.last.longitude,
        ),
      );

      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    }
  }

    buildDurationInTraffic(context) async {
      final directions = dir.GoogleMapsDirections(
      apiKey: 'AIzaSyAwI0xRyzLwnpib7MY2N6dVLUpWi9iMxOw');
      final response = await directions.directionsWithAddress(
        originController.text,
        destinationController.text,
        departureTime: DateTime.now(),
        trafficModel: dir.TrafficModel.bestGuess,
        travelMode: dir.TravelMode.driving,
      );
      if (response.isOkay) {
      final route = response.routes[0];
      final leg = route.legs[0];
      var durationInTraffic = leg.durationInTraffic?.text;
      return durationInTraffic;
      }
      else {
        return 'Error';
      }
    }

  @override
  void dispose() {
    originController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent, 
      elevation: 0,
      margin: const EdgeInsets.all(30),
      child: 
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: 2,
          left: 15,
          right: 15,
          bottom: 20,
        ),
        decoration: BoxDecoration(
        color: const Color.fromARGB(190, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),

        ),
      child: SafeArea(
        child: Stack(
          children: [
              GoogleMap(
                onMapCreated: onMapCreated,
                polylines: _polylines,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.7749, -122.4194), // Default map position (San Francisco)
                  zoom: 12,
                ),
                mapType: MapType.normal,
                compassEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                markers: _markers,
              ),
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            polylines: _polylines,
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.7749, -122.4194), // Default map position (San Francisco)
              zoom: 12,
            ),
          mapType: MapType.normal,
          compassEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          markers: _markers,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CupertinoTextField(
                  controller: originController,
                  decoration:  BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(190, 255, 255, 255),
                      Color.fromARGB(190, 255, 255, 255),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  ),
                const SizedBox(height: 10),
                CupertinoTextField(
                  controller: destinationController,
                 decoration:  BoxDecoration(
                   gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(190, 255, 255, 255),
                      Color.fromARGB(190, 255, 255, 255),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  ),
                const SizedBox(height: 20),
              const SizedBox(height: 5),
              ElevatedButton(onPressed: () async {
                final origin = originController.value.text;
                final destination = destinationController.value.text;
                final durationInTraffic = await buildDurationInTraffic(context);
                setState(() {
                  durationInTrafficController.text = durationInTraffic;
                });

                if(origin == '' || destination == '') {
                  return;
                }

                final TrafficDataModel trafficDataModel = TrafficDataModel(
                  id: null,
                  origin: origin,
                  destination: destination,
                  durationInTraffic: durationInTraffic,
                );

                if(trafficDataModel.id == null) {
                  await DataBaseHelper.insertTrafficData(trafficDataModel);
                }
                else {
                  await DataBaseHelper.updateTrafficData(trafficDataModel);
                }

              },
              onLongPress: _submitData,
              child: Text('Duration In Traffic: ${durationInTrafficController.text}'),
              ),
              ElevatedButton(onPressed: () =>
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => const TrafficDataList()
              ),
              ),
              child: const Text('View Traffic Data'),
              ),
              ],
            ),
          ),
          ],
        ),
      ),),
    );
  }
}
