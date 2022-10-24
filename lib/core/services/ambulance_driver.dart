import 'package:equatable/equatable.dart';

class AmbulanceDriver extends Equatable {
  final String id;
  final String driverName;
  final double driverRating;
  final String ambulanceDetails;
  final String driverPic;

  const AmbulanceDriver(this.id, this.driverName, this.driverPic, this.driverRating,
      this.ambulanceDetails);

  const AmbulanceDriver.named(this.id, this.driverName, this.driverPic,
      this.driverRating, this.ambulanceDetails);

  @override
  List<Object> get props =>
      [id, driverName, driverPic, driverRating, ambulanceDetails];
}
