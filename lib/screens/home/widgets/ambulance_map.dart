// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hosy/core/services/ambulance.dart';
import 'package:hosy/core/services/ambulance_booking.dart';
import 'dart:ui' as ui;
import 'package:hosy/core/services/google_location.dart';
import 'package:hosy/data/location_controller.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_event.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_state.dart';

class AmbulanceMap extends StatefulWidget {
  @override
  _AmbulanceMapState createState() => _AmbulanceMapState();
}

class _AmbulanceMapState extends State<AmbulanceMap> {
  late GoogleMapController controller;
  Set<Marker> markers = Set<Marker>();
  Set<Polyline> polylines = Set<Polyline>();
  Set<Circle> circles = Set<Circle>();
  late GoogleLocation currentLocation;

  @override
  void initState() {
    super.initState();
  }

  void clearData() {
    markers.clear();
    polylines.clear();
    circles.clear();
  }

  Circle createCircle(Color color, LatLng position) {
    return Circle(
        circleId: CircleId(position.toString()),
        fillColor: color,
        strokeColor: color.withOpacity(0.4),
        center: position,
        strokeWidth: 75,
        radius: 32.0,
        visible: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AmbulanceBookingBloc, AmbulanceBookingState>(
        listener: (context, state) {
          if (state is AmbulanceBookingNotSelectedState) {
            List<Ambulance> ambulance = state.ambulanceAvailable;
            clearData();
            addAmbulance(ambulance);
          }
          if (state is AmbulanceBookingConfirmedState) {
            clearData();

            AmbulanceBooking booking = (state).booking;
            addPolylines(booking.source.position, booking.destination.position);
          }
          if (state is AmbulanceNotConfirmedState) {
            clearData();

            AmbulanceBooking booking = (state).booking;
            addPolylines(booking.source.position, booking.destination.position);
          }
        },
        child: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(17.0, 24.0), zoom: 8.0),
          onMapCreated: (controller) async {
            this.controller = controller;
            BlocProvider.of<AmbulanceBookingBloc>(context)
                .add(AmbulanceBookingStartEvent());
            currentLocation = (await LocationController.getCurrentLocation());
            controller.animateCamera(
                CameraUpdate.newLatLngZoom(currentLocation.position, 12));
            BlocProvider.of<AmbulanceBookingBloc>(context)
                .add(AmbulanceBookingStartEvent());
          },
          myLocationButtonEnabled: false,
          markers: markers,
          polylines: polylines,
          circles: circles,
        ),
      ),
    );
  }

  Future addAmbulance(List<Ambulance> Ambulance) async {
    GoogleLocation currentPositon =
        (await LocationController.getCurrentLocation());
    circles.add(createCircle(Colors.blueAccent, currentPositon.position));
    if (this.controller == null) {
      return;
    }
    controller.moveCamera(CameraUpdate.newLatLng(currentPositon.position));
    markers.clear();
    await Future.wait(Ambulance.map((Ambulance) async {
      final Uint8List? markerIcon =
          await getBytesFromAsset("images/Ambulance_marker.png", 100);
      BitmapDescriptor descriptor = BitmapDescriptor.fromBytes(markerIcon!);
      print('Ambulance ${Ambulance.id}');
      markers.add(Marker(
        markerId: MarkerId("${Ambulance.id}"),
        position:
            LatLng(Ambulance.position.latitude, Ambulance.position.longitude),
        infoWindow: InfoWindow(
          title: Ambulance.title,
        ),
        icon: descriptor,
      ));
    }));
    setState(() {});
  }

  Future<Marker> createMarker(
      Color color, LatLng position, String title) async {
    final Uint8List? markerIcon =
        await getBytesFromAsset("images/location.png", 100);
    BitmapDescriptor descriptor = BitmapDescriptor.fromBytes(markerIcon!);
    return Marker(
      markerId: MarkerId("${position.toString()}"),
      position: position,
      infoWindow: InfoWindow(
        title: title,
      ),
      icon: descriptor,
    );
  }

  Future<void> addPolylines(LatLng start, LatLng end) async {
    List<LatLng> result = await LocationController.getPolylines(start, end);

    setState(() {});
    Marker startM = await createMarker(Colors.black, start, "Start");
    Marker endM = await createMarker(Colors.black, end, "End");
    markers.add(startM);
    markers.add(endM);
    for (int i = 1; i < result.length; i++) {
      polylines.add(
        Polyline(
            polylineId: PolylineId("${result[i].toString()}"),
            color: Colors.black,
            points: [result[i - 1], result[i]],
            width: 3,
            visible: true,
            startCap: Cap.roundCap,
            jointType: JointType.mitered,
            endCap: Cap.roundCap,
            geodesic: true,
            patterns: [PatternItem.dash(12)],
            zIndex: 1),
      );
    }
    result.forEach((val) {});

    setState(() {});
    controller.animateCamera(CameraUpdate.newLatLngZoom(result[0], 14));
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }
}
