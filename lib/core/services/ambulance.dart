import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hosy/core/services/ambulance_type.dart';


class Ambulance extends Equatable {
  final String id;
  final String title;
  final bool isAvailable;
  final String plateNo;
  final AmbulanceTypes ambulanceType;
  final LatLng position;

  const Ambulance(this.id, this.title, this.isAvailable, this.plateNo,
      this.ambulanceType, this.position);

  const Ambulance.named(
    this.id,
    this.title,
    this.isAvailable,
    this.plateNo,
    this.ambulanceType,
    this.position,
  );

  @override
  List<Object> get props => [title, isAvailable, plateNo, ambulanceType];
}
