// ignore_for_file: unused_local_variable
import 'package:bloc/bloc.dart';
import 'package:hosy/core/const/path_constants.dart';
import 'package:hosy/core/services/ambulance.dart';
import 'package:hosy/core/services/ambulance_booking.dart';
import 'package:hosy/core/services/ambulance_driver.dart';
import 'package:hosy/core/services/ambulance_type.dart';
import 'package:hosy/core/services/google_location.dart';
import 'package:hosy/core/services/payment_method.dart';
import 'package:hosy/data/ambulance_booking_controller.dart';
import 'package:hosy/data/ambulance_booking_storage.dart';
import 'package:hosy/data/location_controller.dart';
import 'package:hosy/data/payment_method_controller.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_event.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_state.dart';

class AmbulanceBookingBloc
    extends Bloc<AmbulanceBookingEvent, AmbulanceBookingState> {
  AmbulanceBookingBloc(AmbulanceBookingState initialState)
      : super(initialState);

  AmbulanceBookingState get initialState =>
      AmbulanceBookingNotInitializedState();

  Stream<AmbulanceBookingState> mapEventToState(
      AmbulanceBookingEvent event) async* {
    if (event is AmbulanceBookingStartEvent) {
      List<Ambulance> ambulance =
          await AmbulanceBookingController.getAmbulanceAvailable();
      yield AmbulanceBookingNotSelectedState(ambulanceAvailable: ambulance);
    }
    if (event is DestinationSelectedEvent) {
      AmbulanceBookingStorage.open();
      var _;
      yield AmbulanceBookingLoadingState(
          state: DetailsNotFilledState(booking: (_)));

      GoogleLocation source = (await LocationController.getCurrentLocation());
      GoogleLocation destination =
          (await LocationController.getLocationfromId(event.destination));
      await AmbulanceBookingStorage.addDetails(AmbulanceBooking.named(
          '1',
          source,
          destination,
          1,
          DateTime.now(),
          AmbulanceTypes.standard,
          6000.0,
          PaymentMethod('5', 'Pay via M-pesa', PathConstants.payment,
              'Lipa na M-pesa and get a 10% discount'),
          'Get 20% of when ordering today'));
      AmbulanceBooking ambulanceBooking =
          await AmbulanceBookingStorage.getAmbulanceBooking();
      yield DetailsNotFilledState(booking: ambulanceBooking);
    }
    if (event is DetailsSubmittedEvent) {
      var _;
      yield AmbulanceBookingLoadingState(
          state: AmbulanceNotSelectedState(booking: (_)));
      await Future.delayed(Duration(seconds: 1));
      await AmbulanceBookingStorage.addDetails(AmbulanceBooking.named(
          event.id,
          event.source,
          event.destination,
          event.noOfPersons,
          event.bookingTime,
          event.ambulanceType,
          event.estimatedPrice,
          event.paymentMethod,
          event.promoApplied));
      AmbulanceBooking booking =
          await AmbulanceBookingStorage.getAmbulanceBooking();
      yield AmbulanceNotSelectedState(
        booking: booking,
      );
    }
    if (event is AmbulanceSelectedEvent) {
      var _;
      yield AmbulanceBookingLoadingState(
          state:
              PaymentNotInitializedState(booking: (_), methodsAvaiable: []));
      AmbulanceBooking prevBooking =
          await AmbulanceBookingStorage.getAmbulanceBooking();
      double price = await AmbulanceBookingController.getPrice(prevBooking);
      var ambulanceBooking;
      await AmbulanceBookingStorage.addDetails(AmbulanceBooking.named(
        '2',
        ambulanceBooking.source,
        ambulanceBooking.destination,
        5,
        ambulanceBooking.bookingTime,
        AmbulanceTypes.premium,
        6000.50,
        PaymentMethod('5', 'Pay via M-pesa', PathConstants.payment,
            'Lipa na M-pesa and get a 10% discount'),
        'Get 30% off if you\'re within Embakasi',
      ));
      AmbulanceBooking booking =
          await AmbulanceBookingStorage.getAmbulanceBooking();
      List<PaymentMethod> methods =
          (await PaymentMethodController.getMethods()).cast<PaymentMethod>();
      yield PaymentNotInitializedState(
          booking: booking, methodsAvaiable: methods);
    }
    if (event is PaymentMadeEvent) {
      var _;
      yield AmbulanceBookingLoadingState(
          state: PaymentNotInitializedState(booking: (_), methodsAvaiable: []));
      var ambulanceBooking;
      AmbulanceBooking booking =
          await AmbulanceBookingStorage.addDetails(AmbulanceBooking.named(
        '2',
        ambulanceBooking.source,
        ambulanceBooking.destination,
        5,
        ambulanceBooking.bookingTime,
        AmbulanceTypes.premium,
        6000.50,
        PaymentMethod('5', 
        'Pay via M-pesa', 
        PathConstants.payment,
       'Lipa na M-pesa and get a 10% discount'),
        'Get 30% off if you\'re within Embakasi',
      ));
      AmbulanceDriver ambulanceDriver =
          await AmbulanceBookingController.getAmbulanceDriver(booking);
      yield AmbulanceNotConfirmedState(
          booking: booking, driver: ambulanceDriver);
      await Future.delayed(Duration(seconds: 1));
      yield AmbulanceBookingConfirmedState(
          booking: booking, driver: ambulanceDriver);
    }
    if (event is AmbulanceBookingCancelEvent) {
      yield AmbulanceBookingCancelledState();
      await Future.delayed(Duration(milliseconds: 500));
      List<Ambulance> ambulance =
          (await AmbulanceBookingController.getAmbulanceAvailable());
      yield AmbulanceBookingNotSelectedState(ambulanceAvailable: ambulance);
    }
    if (event is BackPressedEvent) {
      switch (state.runtimeType) {
        case DetailsNotFilledState:
          List<Ambulance> ambulance =
              await AmbulanceBookingController.getAmbulanceAvailable();

          yield AmbulanceBookingNotSelectedState(ambulanceAvailable: ambulance);
          break;
        case PaymentNotInitializedState:
          yield AmbulanceNotSelectedState(
              booking: (state as PaymentNotInitializedState).booking);
          break;
        case AmbulanceNotSelectedState:
          yield DetailsNotFilledState(
              booking: (state as AmbulanceNotSelectedState).booking);
          break;
      }
    }
  }
}
