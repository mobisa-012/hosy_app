// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/core/services/payment_method.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_event.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_state.dart';
import 'package:hosy/screens/home/widgets/rounded_button.dart';


class AmbulanceBookingPaymentsWidget extends StatefulWidget {
  const AmbulanceBookingPaymentsWidget({super.key});

  @override
  AmbulanceBookingPaymentsWidgetState createState() =>
      AmbulanceBookingPaymentsWidgetState();
}

class AmbulanceBookingPaymentsWidgetState
    extends State<AmbulanceBookingPaymentsWidget> {
  List<PaymentMethod> methods = [];
  late PaymentMethod selectedMethod;

  @override
  void initState() {
    super.initState();
    methods = (BlocProvider.of<AmbulanceBookingBloc>(context).state
            as PaymentNotInitializedState)
        .methodsAvaiable;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Select Payment",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) {
                      return buildPaymentMethod(methods[index]);
                    },
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    separatorBuilder: (context, index) => Container(
                      height: 18.0,
                    ),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: methods.length,
                  ),
                  Text(
                    "Promo Code",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  buildInputWidget(null, "Add promo code", () {})
                ],
              ),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            RoundedButton(
              onTap: () {
                BlocProvider.of<AmbulanceBookingBloc>(context)
                    .add(BackPressedEvent());
              },
              iconData: Icons.keyboard_backspace, text: '',
            ),
            const SizedBox(
              width: 18.0,
            ),
            Expanded(
              flex: 2,
              child: RoundedButton(
                text: "Confirm Payment",
                onTap: () {
                  BlocProvider.of<AmbulanceBookingBloc>(context)
                      .add(PaymentMadeEvent(paymentMethod: selectedMethod));
                }, iconData: Icons.done,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildPaymentMethod(PaymentMethod method) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = method;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: const Color(0xffeeeeee).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                method.icon,
                width: 56.0,
                height: 56.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    method.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    method.description,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            selectedMethod == method
                ? const Icon(
                    Icons.check_circle,
                    size: 28.0,
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  )
          ],
        ),
      ),
    );
  }

  Widget buildInputWidget( Null, String text, Function() onTap) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xffeeeeee).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: text == null ? Colors.black45 : Colors.black),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
